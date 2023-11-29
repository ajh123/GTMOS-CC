---
module: [kind=guide] building_docs
---

# Building Documentation

Effective documentation is crucial for any project, aiding both users and developers in understanding its intricacies. This guide outlines the straightforward steps to build the documentation for GT MOS - CC, complete with our own set of comprehensive documentation.

## Prerequisites: illuaminate Downloads

Before proceeding, download [illuaminate](https://github.com/SquidDev/illuaminate), the tool we utilise to construct documentation from Markdown and Lua files. Choose the appropriate version for your platform:

- x86-64 Linux: [illuaminate-linux-x86_64](https://squiddev.cc/illuaminate/bin/latest/illuaminate-linux-x86_64)
- x86-64 Windows: [illuaminate-windows-x86_64.exe](https://squiddev.cc/illuaminate/bin/latest/illuaminate-windows-x86_64.exe)

Alternatively, you can access [illuaminate's source code](https://github.com/SquidDev/illuaminate) and compile it yourself.

## Building the Docs

1. Clone the [GT MOS - CC repository](https://github.com/ajh123/GTMOS-CC) using Git:

    ```bash
    git clone https://github.com/ajh123/GTMOS-CC.git
    ```

2. Navigate to the code directory and execute the following command to use illuaminate for documentation generation:

    ```bash
    cd GTMOS-CC
    illuaminate doc-gen
    ```

3. After completion, you'll find the generated documentation in the `/out/doc` folder. To view the documentation, open the `index.html` file in your preferred browser:

    ```bash
    cd out/doc
    xdg-open index.html  # For Linux
    start index.html     # For Windows
    ```

Bookmark the documentation URL for convenient future access.

## Credits

> [!NOTE]
> Our sincere thanks goes to [SquidDev](https://github.com/SquidDev) and the [CC: Tweaked contributors](https://github.com/cc-tweaked/CC-Tweaked/graphs/contributors) for their contributions to illuaminate and the CC: Tweaked documentation, which helped us understand illuaminate.
