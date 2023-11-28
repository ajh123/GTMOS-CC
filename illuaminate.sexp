; -*- mode: Lisp;-*-

(sources
  /doc/
  /api/
  /programs/shell/main.lua
)

(doc
  (destination /out/doc)
  (index doc/index.md)

  (site
    (title "GT MOS - CC")
    (url https://docs.minersonline.uk/cc/gtmos)
    (source-link https://github.com/ajh123/GTMOS-CC/blob/${commit}/${path}#L${line})

    (head doc/head.html)
  )

  (module-kinds
    (guide Guides)
    (program Programs)
    (changelog Changelog)
  )

  (library-path
    /api/
  )
)

(at /
  (linters
    syntax:string-index
    doc:docusaurus-admonition
    doc:ldoc-reference

    ;; It'd be nice to avoid this, but right now there's a lot of instances of
    ;; it.
    -var:set-loop

    ;; It's useful to name arguments for documentation, so we allow this. It'd
    ;; be good to find a compromise in the future, but this works for now.
    -var:unused-arg
  )

  (lint
    (bracket-spaces
      (call no-space)
      (function-args no-space)
      (parens no-space)
      (table space)
      (index no-space)
    )

    (allow-clarifying-parens true)

    ;; colours imports from colors, and we don't handle that right now.
    ;; keys is entirely dynamic, so we skip it.
    (dynamic-modules colours keys _G)

    (globals
      :max
      _CC_DEFAULT_SETTINGS
      _HOST
      ;; Ideally we'd pick these up from bios.lua, but illuaminate currently
      ;; isn't smart enough.
      sleep write printError read rs
    )
  )
)
