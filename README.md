# build-gcc-cross-compiler

A `bash` script for `Debian` systems to build a `gcc` cross-compiler for os development or other applications. Inspired by [this repo](https://github.com/andrewrobinson5/Cross-Compiler-Build-Script).
The script builds `gcc` and `binutils` simply. It only requires the target triplet as an argument.

This what the script does:

- It will download the source code for `gcc` and `binutils` via `wget`,
- build them via `make`,
- and install them in the `~/cross` directory.

# usage

- Copy the `cross-compile-gcc.sh` script in your `home`(`~/`) directory and launch it from the terminal using the following command:

  ```sh
  ./cross-compile-gcc.sh i686-elf
  ```

- Replace `i686-elf` with your target triple and you are set. It will do everything. It will create all the directories you need, download `gcc 13.2.0` and `binutils 2.42` and build them together. It even installs the dependencies for you.

- You can add this line to the end of your `.bashrc` or `.zshrc` file( _or whatever shell resource configuration file you are using_ )

  ```sh
  export CROSS_PATH="$HOME/cross/bin"
  export PATH="$CROSS_PATH:$PATH"
  ```

- Then ask your shell to reload the configuration file by running:

  ```sh
    source ~/.bashrc
    # or
    source ~/.zshrc
  ```

- Then you can use the cross-compiler by running the following command to check if it is installed:

  ```sh
  i686-elf-gcc --version
  ```

# notes

- In case you want to find the downloaded source code, it will be in the `~/cross/src` directory and the compiled binaries will be in the `~/cross/bin` directory.

- Common target triples are `x86_64-elf` and `i386-elf`, others include:

  - `i686-elf`
  - `x86_64-elf`
  - `arm-none-eabi`
  - `aarch64-none-elf`

_Read more about target triples [here](https://wiki.osdev.org/Target_Triplet)_.

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
