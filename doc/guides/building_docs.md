---
module: [kind=guide] building_docs
---

# Building GT MOS - CC documentation

Building the GT MOS - CC documentation can be done in a few simple steps. Documentation is important for any project, it will allow users and developers understand it. For GT MOS - CC we have our own documentation.

## illuaminate downloads

To build the documentation you need to download [illuaminate](https://github.com/SquidDev/illuaminate), illuaminate is the tool we use to construct the documentation from Markdown and Lua files.

* x86-64 Linux - <https://squiddev.cc/illuaminate/bin/latest/illuaminate-linux-x86_64>
* x86-64 Windows - <https://squiddev.cc/illuaminate/bin/latest/illuaminate-windows-x86_64.exe>

Or you may view [illuaminate's source code](https://github.com/SquidDev/illuaminate) and compile it yourself.

## Building the docs

To build the docs you need to download the [GT MOS - CC repository](https://github.com/ajh123/GTMOS-CC) with git:

```bash
git clone https://github.com/ajh123/GTMOS-CC.git
```

Once you have the code you may use illuaminate to build the docs. Just navigate to the folder where the code was placed and run:

```bash
illuaminate doc-gen
```

Once that was done you should have a `/out/doc` folder, containing a website of the documentation. Just open the `index.html` file in your favourite browser and you will see the documentation.
