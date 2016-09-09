encrypt-dir-encfs
=================

A low-tech solution to encrypt a directory.

Requirements
------------

- Bash: to run scripts to safely mount and unmount the encrypted directory
- [EncFS][1]: to encrypt the contents of a directory

Be careful when performing major upgrades to your operating system.
If shared libraries used by `encfs` are replaced or removed,
`encfs` might become unable to mount the encrypted directory.
When performing major operating system upgrades,
copy the content (unencrypted) as a backup before starting the upgrade.
After the upgrade is completed and you have confirmed that the
encrypted content is accessible, you can delete the backup.

Usage
-----

1. Run `./mount.sh` and enter your password to access the encrypted content.
2. Add or edit or delete files inside the `content/` directory.
3. When done editing files, run `./umount.sh`.

If no process is actively locking open files in `content/`,
the directory should unmount itself after 5 minutes of inactivity,
as configured inside the `./mount.sh` script.

First-time setup
----------------

When running `./mount.sh` for the first time,
the encrypted directory doesn't exist yet,
and `encfs` will ask you to create it:

>     The directory "/path/to/project/encrypt-dir-encfs/raw/" does not exist. Should it be created? (y,n)

Say `y`. There will be one more question:

>     Creating new encrypted volume.
>     Please choose from one of the following options:
>      enter "x" for expert configuration mode,
>      enter "p" for pre-configured paranoia mode,
>      anything else, or an empty line will select standard mode.
>     ?>

Standard mode is fine.

>     Standard configuration selected.
> 
>     Configuration finished.  The filesystem to be created has
>     the following properties:
>     Filesystem cipher: "ssl/aes", version 3:0:2
>     Filename encoding: "nameio/block", version 4:0:2
>     Key Size: 192 bits
>     Block Size: 1024 bytes
>     Each file contains 8 byte header with unique IV data.
>     Filenames encoded using IV chaining mode.
>     File holes passed through to ciphertext.
> 
>     Now you will need to enter a password for your filesystem.
>     You will need to remember this password, as there is absolutely
>     no recovery mechanism.  However, the password can be changed
>     later using encfsctl.
> 
>     New Encfs Password:

Choose your password wisely.
You will have to re-enter this password every time you mount the encrypted directory.
If you lose this password, the data is not recoverable.

How it works
------------

Encrypted content is stored in the `raw/` directory,
and it's only usable through `encfs`.

The `mount.sh` script mounts the `raw/` directory as `content/`.
While mounted,
you can access the human-readable content in `content/`.
No other user can access it, not even `root`.

The `umount.sh` script unmounts the `raw/` directory and deletes the `content/` directory.
If you copy files out of `content/` before unmounting,
the copied files will of course remain human-readable.
Only files under `raw/` are encrypted.

Version control of the encrypted content
----------------------------------------

If you want to version control the encrypted content,
you can add and commit the changes in `raw/`.
There are helper scripts to make this easy.

First of all,
the `./__wipe-vcs.sh` script erases and recreates the repository.
This is useful right after you cloned this repository to start your own private storage,
or when you want to reset the history to save storage.

The `./commit.sh` script simplifies regular commits:

1. Unmount the encrypted directory
2. Add changes in `raw/` and commit with an empty message
3. Run `git push`

The commit message is empty to reveal nothing about the content.
If you want to do differently,
you can commit manually instead of using `./commit.sh`.

You may want to use version control inside `content/` (too),
and safely use meaningful commit messages.

Changing the password
---------------------

It's possible to change the password using the `encfsctl` command, for example:

    $ encfsctl passwd raw
    Enter current Encfs password
    EncFS Password:
    Enter new Encfs password
    New Encfs Password:
    Verify Encfs Password:
    Volume Key successfully updated.

You must know the current password to do this.
If you lost the current password,
the data is not recoverable.

[1]: https://en.wikipedia.org/wiki/EncFS
