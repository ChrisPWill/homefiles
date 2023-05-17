{theme}: let
  colors = theme.normal;
  lcolors = theme.light;
in {
  enable = true;
  userSettings = {
    editor = {
      fontFamily = "'FantasqueSansMono Nerd Font Mono', Menlo, Monaco, 'Courier New', monospace";
      defaultFormatter = "esbenp.prettier-vscode";
      formatOnSave = true;

      tokenColorCustomizations.textMateRules = [
        {
          name = "comments";
          scope = [
            "comment"
            "punctuation.definition.comment"
            "string.quoted.docstring"
          ];
          settings = {
            fontStyle = "italic";
            foreground = lcolors.white;
          };
        }
        {
          name = "yellow: module attributes, types, function call parameters";
          scope = [
            "constant.type-constructor.elm"
            "entity.name.class.lua"
            "entity.name.function.asciidoc"
            "keyword.control.at-rule"
            "markup.heading.blocktitle.asciidoc"
            "markup.table.cell.delimiter.asciidoc"
            "meta.attribute.rust"
            "meta.function-call.arguments.python"
            "meta.function-call.c"
            "meta.function-call.cpp"
            "meta.function-call.crystal variable.other.crystal"
            "meta.function-call.erlang variable.other.erlang"
            "meta.function-call.php variable.other.php"
            "meta.function-call.ruby variable.other.ruby"
            "meta.function-call.with-arguments.js variable.other.constant.js"
            "meta.function-call.with-arguments.js variable.other.readwrite.js"
            "meta.method-call.with-arguments.js variable.other.constant.js"
            "meta.method-call.with-arguments.js variable.other.readwrite.js"
            "meta.symbol.clojure"
            "parameter.variable.function.elixir"
            "source.cpp entity.name.scope-resolution"
            "source.haskell constant"
            "source.java storage.type"
            "support.class.dart"
            "support.function.go"
            "support.type.builtin.class.flowtype"
            "support.type.builtin.primitive.flowtype"
            "support.type.class.flowtype"
            "text.html.derivative variable.language"
            "variable.other.readwrite"
          ];
          settings.foreground = colors.yellow;
        }
        {
          name = "orange: numbers, language constants, tags";
          scope = [
            "constant.language"
            "constant.numeric"
            "entity.name.function.macro.erlang"
            "entity.name.tag"
            "markup.changed.git_gutter"
            "markup.deleted.git_gutter"
            "markup.fenced_code.block.markdown"
            "markup.inline.raw.string.markdown"
            "markup.raw.block.fenced.markdown"
            "markup.raw.block"
            "support.class"
            "support.constant.core.rust"
            "support.constant.property-value.css"
            "support.function.general.tex"
            "text.asciidoc markup.raw"
            "text.html.markdown markup.inline.raw.markdown"
            "variable.language.elixir"
            "variable.language.ruby"
          ];
          settings.foreground = lcolors.orange;
        }
        {
          name = "yellow: classes, modules, language variables";
          scope = [
            "entity.name.class"
            "entity.name.package.go"
            "entity.name.section"
            "entity.name.type.class"
            "entity.name.type.interface.ts"
            "entity.name.type.module"
            "entity.other.inherited-class"
            "keyword.control.preamble.latex"
            "source.haskell entity.name.namespace"
            "text.asciidoc markup.heading"
            "variable.language"
          ];
          settings.foreground = colors.yellow;
        }
        {
          name = "silver: default for variables and constants";
          scope = [
            "constant"
            "entity.name.function.java"
            "entity.name.function.member.cpp"
            "entity.name.record.field.accessor.elm"
            "entity.name.type.class.module.erlang"
            "JSXNested"
            "keyword.other.unit"
            "meta"
            "storage.modifier.import.java"
            "support.class.crystal"
            "support.constant.ext.php"
            "variable.language.prototype.js"
            "variable.other.block.crystal"
            "variable.other.block.ruby"
            "variable.other.constant"
            "variable.other.crystal"
            "variable.other.erlang"
            "variable.other.lua"
            "variable.other.object.cs"
            "variable.other.object.js"
            "variable.other.php"
            "variable.other.readwrite.js"
            "variable.other.ruby"
            "variable"
          ];
          settings.foreground = colors.silver;
        }
        {
          name = "orange: properties";
          scope = [
            "variable.other.object.property.cs"
            "variable.other.object.property.ts"
            "variable.other.property.cpp"
            "variable.other.property.java"
            "variable.other.property.js"
            "variable.other.property.ts"
          ];
          settings.foreground = colors.orange;
        }
        {
          name = "red: invalid";
          scope = [
            "invalid.deprecated"
            "invalid.illegal"
            "invalid"
          ];
          settings.foreground = colors.red;
        }
        {
          name = "blue: keywords, control, storage";
          scope = [
            "constant.asciidoc"
            "constant.character.asciidoc"
            "entity.other.attribute-name.class.css"
            "kewyword.operator.union.flowtype"
            "keyword.control.flow"
            "keyword.control.newline.tex"
            "keyword"
            "markdown.heading"
            "markup.heading | markup.heading entity.name"
            "markup.heading.markdown punctuation.definition.heading.markdown"
            "markup.heading.marker.asciidoc"
            "markup.heading.setext"
            "markup.macro.inline.passthrough.asciidoc"
            "markup.other.url.asciidoc"
            "markup.quote punctuation.definition.blockquote.markdown"
            "markup.substitution.attribute-reference.asciidoc"
            "markup.table.delimiter.asciidoc"
            "meta.separator"
            "meta.structure.tuple.erlang"
            "meta.vector.clojure"
            "punctuation.accessor.cs"
            "punctuation.accessor.ts"
            "punctuation.definition.asciidoc"
            "punctuation.definition.constant.elixir"
            "punctuation.definition.constant.ruby"
            "punctuation.definition.list.begin.markdown"
            "punctuation.definition.quote.begin.markdown"
            "punctuation.definition.raw.markdown"
            "punctuation.dot.dart"
            "punctuation.other.colon.go"
            "punctuation.other.period.go"
            "punctuation.separator.asciidoc"
            "punctuation.separator.clause-head-body.erlang"
            "punctuation.separator.colon.python"
            "punctuation.separator.dict.python"
            "punctuation.separator.dictionary.key-value.json"
            "punctuation.separator.dot-access"
            "punctuation.separator.key-value"
            "punctuation.separator.method.crystal"
            "punctuation.separator.method.elixir"
            "punctuation.separator.method.ruby"
            "punctuation.separator.module-function.erlang"
            "punctuation.separator.namespace.access.cpp"
            "punctuation.separator.namespace.ruby"
            "punctuation.separator.other.crystal"
            "punctuation.separator.period.java"
            "punctuation.separator.period.python"
            "punctuation.separator.pointer-access.c"
            "punctuation.separator.pointer-access"
            "punctuation.separator.variable.crystal"
            "punctuation.separator.variable.ruby"
            "punctuation.type.flowtype"
            "source.cpp punctuation.separator.scope-resolution"
            "source.python punctuation.section"
            "source.rust storage.modifier"
            "storage.modifier.import.java punctuation.separator.java"
            "storage"
            "support.asciidoc"
            "support.function.be.latex"
            "support.function.section.latex"
            "support.function.textbf.latex"
            "support.function.textit.latex"
            "support.function.url.latex"
            "text.asciidoc constant.other.symbol"
            "text.asciidoc markup.code"
            "variable.line-break.asciidoc"
            "variable.other.anonymous.elixir punctuation.definition.variable.elixir"
          ];
          settings.foreground = lcolors.blue;
        }
        {
          name = "foreground: punctuation and noise";
          scope = [
            "meta.var"
            "constant.language.unit.haskell"
            "markup.heading.block-attribute.asciidoc"
            "meta.preprocessor.haskell"
            "meta.tag"
            "punctuation.definition.fenced.markdown"
            "punctuation.definition"
            "punctuation"
            "text.asciidoc markup.code markup.heading"
          ];
          settings.foreground = theme.foreground;
        }
        {
          name = "magenta: imports and exports";
          scope = [
            "keyword.control.import"
            "keyword.control.from"
            "keyword.control.export"
            "keyword.control.default"
            "keyword.control.as"
          ];
          settings.foreground = colors.magenta;
        }
        {
          name = "magenta: interpolations, regular expressions";
          scope = [
            "constant.character.format.placeholder.other.python"
            "constant.numeric.math.tex"
            "constant.other.placeholder.go"
            "entity.other.attribute-name.id.css"
            "markup.list.bullet.asciidoc"
            "meta.declaration.exports.haskell entity.name.function.haskell"
            "punctuation.definition.template-expression.begin"
            "punctuation.definition.template-expression.end"
            "punctuation.quasi.element.begin.js"
            "punctuation.quasi.element.end.js"
            "punctuation.section.embedded"
            "storage.type.format.python"
            "string.other.link.description.markdown"
            "string.other.link.title.markdown"
            "string.regexp constant.character"
            "string.regexp constant"
            "string.regexp keyword"
            "string.regexp meta keyword"
            "string.regexp meta punctuation meta.assertion"
            "string.regexp meta punctuation"
            "string.regexp meta.group"
            "string.regexp punctuation"
            "string.regexp"
            "support.class.builtin.js"
            "support.class.latex"
            "support.class.math.latex"
            "support.function.core.rust"
            "variable.interpolation"
            "variable.other.readwrite.global.pre-defined.ruby"
            "variable.other.readwrite.global.ruby"
          ];
          settings.foreground = lcolors.magenta;
        }
        {
          name = "green: function definitions";
          scope = [
            "entity.global.clojure"
            "entity.name.function"
            "entity.name.section.latex"
            "entity.other.attribute-name.pseudo-class.css"
            "entity.other.attribute-name.pseudo-element.css"
            "keyword.control.layout.tex"
            "keyword.control.ref.latex"
            "keyword.type.cs"
            "markup.italic.quotes.asciidoc"
            "meta.function.embedded.latex"
            "meta.function.lua entity.name.function.lua"
            "meta.method.identifier entity.name.function.java"
            "storage.type.core.rust"
            "storage.type.cs"
            "support.function.magic.python"
            "variable.language.dart"
          ];
          settings.foreground = colors.green;
        }
        {
          name = "orange: atoms, function params, list items, types";
          scope = [
            "constant.keyword.clojure"
            "constant.language.symbol"
            "constant.other.reference.label.latex"
            "constant.other.reference.link.markdown"
            "constant.other.symbol"
            "entity.name.record"
            "entity.name.tag.css"
            "entity.name.type.namespace.scope-resolution.cpp"
            "entity.name.variable.parameter.cs"
            "markup.heading.asciidoc"
            "markup.heading.block-attribute.asciidoc"
            "markup.list meta.paragraph.markdown"
            "markup.meta.attribute-list.asciidoc"
            "meta.function-call.java"
            "meta.function.parameters variable.other.readwrite"
            "meta.function.parameters.js variable.other.readwrite.js"
            "meta.function.parameters.php variable.other.php"
            "meta.method-call.java"
            "punctuation.section.list.begin.elixir"
            "punctuation.section.list.end.elixir"
            "punctuation.section.regexp.begin.elixir"
            "punctuation.section.regexp.end.elixir"
            "source.crystal variable.other.readwrite"
            "storage.type.elm"
            "storage.type.haskell"
            "support.constant.attribute-name.asciidoc"
            "text.asciidoc markup.macro.block.general string.unquoted"
            "text.asciidoc markup.other.url string.unquoted"
            "variable.language.rust"
            "variable.other"
            "variable.parameter"
            "variable.type.elm"
          ];
          settings.foreground = lcolors.orange;
        }
        {
          name = "forest green: strings";
          scope = [
            "markup.heading"
            "markup.inserted.git_gutter"
            "markup.mark.asciidoc"
            "string"
            "text.asciidoc markup.link"
            "variable.parameter.url.css"
          ];
          settings.foreground = colors.green;
        }
        {
          name = "blue: keys, function calls";
          scope = [
            "constant.other.general.math.tex"
            "entity.name.function.call.cpp"
            "entity.name.function.clojure"
            "entity.name.function.cs"
            "entity.name.function.dart"
            "entity.name.function.lua"
            "entity.name.function.rust"
            "entity.name.record.field.elm"
            "entity.other.attribute-name"
            "entity.other.inherited-class.haskell"
            "markup.admonition.asciidoc"
            "markup.heading.list.asciidoc"
            "markup.heading.list.asciidoc"
            "meta.function-call entity.name.function"
            "meta.function-call.crystal entity.name.function.crystal"
            "meta.function-call.php"
            "meta.method-call entity.name.function"
            "meta.object-literal.key"
            "meta.object.flowtype storage.type.function.js"
            "meta.object.flowtype variable.other.readwrite.js"
            "meta.property-name"
            "source.python meta.function-call"
            "string.other.link.description.title.markdown"
            "support.class.ruby"
            "support.function.builtin.go"
            "support.function.construct.php"
            "support.function.lua"
            "support.function.mutator.js"
            "support.module.elm"
            "support.type.property-name"
            "variable.other.constant.elixir"
            "variable.other.object.access.cpp"
            "variable.other.object.java"
            "variable.other.object.ts"
            "variable.other.object"
          ];
          settings.foreground = colors.blue;
        }
        {
          name = "cyan: escapes, placeholders";
          scope = [
            "constant.character.escape"
            "constant.character.numeric.regexp"
            "constant.character"
            "markup.highlight.asciidoc"
            "string constant.other.placeholder"
          ];
          settings.foreground = colors.cyan;
        }
        {
          name = "blue: JS method names";
          scope = [
            "entity.name.method.js"
          ];
          settings = {
            foreground = colors.blue;
          };
        }
        {
          name = "yellow: self, this";
          scope = [
            "markup.admonition entity.name.function.asciidoc"
            "variable.language.self.crystal"
            "variable.language.special.self.python"
            "variable.language.this"
          ];
          settings = {
            foreground = colors.yellow;
          };
        }
        {
          name = "yellow: HTML attributes";
          scope = [
            "text.html.basic entity.other.attribute-name"
          ];
          settings = {
            foreground = colors.yellow;
          };
        }
        {
          name = "URL";
          scope = [
            "*url*"
            "*link*"
            "*uri*"
          ];
          settings.fontStyle = "underline";
        }
        {
          name = "markdown italic delimiters, ES7 bind operator";
          scope = [
            "punctuation.definition.italic.markdown"
            "source.js constant.other.object.key.js string.unquoted.label.js"
          ];
          settings = {
            fontStyle = "italic";
          };
        }
        {
          name = "markup italic text";
          scope = [
            "markup.italic"
          ];
          settings = {
            fontStyle = "italic";
          };
        }
        {
          name = "markup bold text";
          scope = [
            "markup.bold markup.italic string"
            "markup.bold markup.italic"
            "markup.bold string"
            "markup.bold"
            "markup.italic markup.bold string"
            "markup.italic markup.bold"
            "markup.quote markup.bold string"
            "markup.quote markup.bold"
          ];
          settings = {
            fontStyle = "bold";
          };
        }
        {
          name = "markdown bold delimiters";
          scope = [
            "punctuation.definition.bold.markdown"
          ];
          settings = {
            fontStyle = "bold";
          };
        }
        {
          name = "markup underline";
          scope = [
            "markup.underline"
          ];
          settings = {
            fontStyle = "underline";
          };
        }
        {
          name = "markup block quote";
          scope = [
            "markup.quote meta.paragraph.markdown"
          ];
          settings = {
            fontStyle = "italic";
            foreground = lcolors.lightgray;
          };
        }
        {
          name = "markup inserted";
          scope = [
            "markup.inserted"
          ];
          settings.foreground = colors.green;
        }
        {
          name = "markup deleted";
          scope = [
            "markup.deleted"
          ];
          settings.foreground = colors.red;
        }
        {
          name = "markup changed";
          scope = [
            "markup.changed"
          ];
          settings.foreground = colors.blue;
        }
        {
          scope = "token.info-token";
          settings.foreground = "#268bd2";
        }
        {
          scope = "token.warn-token";
          settings.foreground = "#d33682";
        }
        {
          scope = "token.error-token";
          settings.foreground = "#dc322f";
        }
        {
          scope = "token.debug-token";
          settings.foreground = "#407875";
        }
      ];
    };

    window = {
      autoDetectColorScheme = true;
      zoomLevel = 1;
    };

    javascript.updateImportsOnFileMove.enabled = "never";

    terminal.integrated.shellIntegration.history = 0;

    debug.javascript.autoAttachFilter = "always";
  };
}
