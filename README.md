# Tiny Binaries

A collection of assembly programs crafted for extremely minimal executable size.

## ⚠️ Unsafe - Educational Use Only

These binaries are unsafe as a consequence of extreme size optimization. They:

- **Skip all error handling** on syscalls—failures are silent with no indication
- **Have no bounds checking or input validation**—no protection against malformed input or buffer overflows
- **Assume specific kernel and CPU behavior** (register state, ELF loader specifics)—will crash or misbehave if assumptions don't hold

These are proof-of-concept explorations of manually written assembly. **Do not use in production or any real-world context.**

## Why?

A regular hello world program in C compiles to ~14 kilobytes. This project explores how small we can make these binaries through assembly optimization—a fun challenge in understanding the costs of abstraction.

## How?

Size reductions are achieved through:

- **Minimal structure** - Skip C runtime startup, dynamic linking, and metadata sections (e.g., `.dynamic`, `.got`, `.eh_frame`, `.note.*`)
- **Direct syscalls** - Calling the kernel directly instead of going through libc wrappers
- **Minimal code** - Only essential instructions, no loops or conditionals unless necessary

The ELF format requires ~84 bytes minimum (ELF header + program header). The rest is code and data.

Result: hello-world in 115 bytes total vs. 14 KB—a 122x reduction.

## Requirements

Each tiny binary must meet these constraints:

- **Functional correctness** - Must perform the program's intended function (e.g., exit code for `true`, output for `yes`, file reading for `cat`). Side effects don't matter (e.g., `hello-world` exits with code 1, not 0)
- **Platform compatibility** - Must run on 32-bit x86 Linux or x86-64 Linux with IA-32 support
- **Valid ELF executable** - Must be a valid ELF binary (not DOS COM, PE, or other formats requiring emulation)
- **No external dependencies** - Must be fully self-contained (no libc, no runtime libraries)
- **Single executable file** - Must be a single binary file with no external scripts or support files
- **Direct syscalls only** - Cannot use libc wrappers; must call syscalls directly
- **Minimize size** - Binary size is the primary optimization goal

## Prerequisites

- NASM
- GCC
- GNU make

## Status

| Program | Status | Bytes |
|---------|--------|-------|
| hello-world | ✅ | 115 |
| factorial | ⏳ | - |
| fibonacci | ⏳ | - |
| echo | ⏳ | - |
| date | ⏳ | - |
| simple HTTP "Hello" server | ⏳ | - |
| GNU Coreutils | ⏳ | - |

## Build & Test

```bash
# clone the repo
git clone https://github.com/AlphaLynx0/tiny-bins.git
cd tiny-bins/hello-world

# assemble, compile, and compare both versions
make savings
```

Each subdirectory follows the same pattern:
- `make` builds both the ASM and C versions
- `make listing` shows the assembly instruction breakdown with byte offsets and sizes
- `make savings` compares their sizes
- `make test` (if implemented) tests the output of ASM and reference binaries
- `make clean` deletes binaries and listing files

## License

MIT © AlphaLynx <alphalynx@alphalynx.dev>
