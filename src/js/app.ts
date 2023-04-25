/* eslint no-console:0 */
require("@rails/ujs").start();

// import * as twind from '@twind/core'
// import config from './twind.config'
// twind.install(config)

import "@fortawesome/fontawesome-free/js/all";

import flourite from 'flourite';
import CodeMirror from 'codemirror';
import 'codemirror/mode/htmlmixed/htmlmixed';
import 'codemirror/mode/css/css';
import 'codemirror/mode/javascript/javascript';
import 'codemirror/mode/markdown/markdown';
import 'codemirror/mode/gfm/gfm';
import 'codemirror/mode/yaml/yaml';
import 'codemirror/mode/xml/xml';
import 'codemirror/mode/php/php';
import 'codemirror/mode/ruby/ruby';
import 'codemirror/mode/python/python';
import 'codemirror/mode/shell/shell';
import 'codemirror/mode/clike/clike';
import 'codemirror/mode/go/go';
import 'codemirror/mode/rust/rust';
import 'codemirror/mode/swift/swift';
import 'codemirror/mode/dart/dart';
import 'codemirror/mode/sql/sql';
import 'codemirror/mode/dockerfile/dockerfile';
import 'codemirror/mode/haskell/haskell';
import 'codemirror/mode/lua/lua';
import 'codemirror/mode/perl/perl';
import 'codemirror/mode/r/r';
import 'codemirror/mode/scheme/scheme';
import 'codemirror/mode/clojure/clojure';
import 'codemirror/mode/erlang/erlang';
import 'codemirror/mode/julia/julia';
import 'codemirror/mode/crystal/crystal';

import 'prismjs';
import 'prismjs/components/prism-markup';
import 'prismjs/components/prism-markup-templating';
import 'prismjs/components/prism-css';
import 'prismjs/components/prism-javascript';
import 'prismjs/components/prism-json';
import 'prismjs/components/prism-yaml';
import 'prismjs/components/prism-xml-doc';
import 'prismjs/components/prism-php';
import 'prismjs/components/prism-ruby';
import 'prismjs/components/prism-python';
import 'prismjs/components/prism-bash';
import 'prismjs/components/prism-zig';
import 'prismjs/components/prism-shell-session';
import 'prismjs/components/prism-go';
import 'prismjs/components/prism-rust';
import 'prismjs/components/prism-swift';
import 'prismjs/components/prism-dart';
import 'prismjs/components/prism-sql';
import 'prismjs/components/prism-docker';
import 'prismjs/components/prism-haskell';
import 'prismjs/components/prism-lua';
import 'prismjs/components/prism-perl';
import 'prismjs/components/prism-r';
import 'prismjs/components/prism-scheme';
import 'prismjs/components/prism-clojure';
import 'prismjs/components/prism-erlang';
import 'prismjs/components/prism-julia';
import 'prismjs/components/prism-crystal';

import '../css/app.scss';


declare global {
  function copyValue(str: string): void

  interface Window {
    enabledLanguages: string[]
  }
}

// Copy the given value to the user's clipboard
globalThis.copyValue = (str: string) => {
  navigator.clipboard.writeText(str).then(() => {
    console.log("Copied to clipboard");
  });
}

// ███████ ██████  ██ ████████  ██████  ██████  
// ██      ██   ██ ██    ██    ██    ██ ██   ██ 
// █████   ██   ██ ██    ██    ██    ██ ██████  
// ██      ██   ██ ██    ██    ██    ██ ██   ██ 
// ███████ ██████  ██    ██     ██████  ██   ██ 

// A list of common languages that we want to be available to use in the editor.
const enabledLanguages = window.enabledLanguages;

let editor: CodeMirror.Editor;
const editorTextArea = document.getElementById("editor") as HTMLTextAreaElement;
if (editorTextArea) {
  editor = CodeMirror.fromTextArea(editorTextArea, {
    lineNumbers: true,
    lineWrapping: true,
    mode: "htmlmixed",
  });
  
  // If the editor is disabled, make it read-only and remove the cursor
  if (editorTextArea.disabled) {
    editor.setOption("readOnly", true);
    editor.setOption("autofocus", false);
    editor.setOption("cursorBlinkRate", -1);
  }
  
  // When the codemirror editor detects a change, start a timer. When it expires, use flourite to
  // detect the language and update the codemirror mode.
  const languageSelector = document.getElementById("language-selector") as HTMLSelectElement | null;

  // Set the editor mode to the given language.
  function setMode(language: string) {
    // Some languages will require additional configuration.
    switch (language) {
      case 'Markdown':
        editor.setOption("mode", { name: "gfm", base: "markdown" });
        break;
      // Clike languages
      case 'C':
      case 'C++':
      case 'C#':
      case 'Java':
      case 'Kotlin':
      case 'Scala':
        editor.setOption("mode", { name: "clike", base: "text" });
        break;
      // Javascript-like languages
      case 'TypeScript':
      case 'JavaScript':
      case 'JSON':
        editor.setOption("mode", { name: "javascript", base: "text" });
        break;
      default:
        editor.setOption("mode", language.toLowerCase());
        break;
    }
  }

  // Look for the `data-language` attribute on the editor element. If it's set, use that
  // language instead of trying to detect it.
  const dataLanguage = editorTextArea.getAttribute("data-language");
  if (dataLanguage) {
    setMode(dataLanguage);
    if (languageSelector) {
      languageSelector.value = dataLanguage;
    }
  }
  
  if (languageSelector) {
    // Add all the enabled languages to the language selector
    for (const language of enabledLanguages) {
      const option = document.createElement("option");
      option.value = language;
      option.innerText = language;
      languageSelector.appendChild(option);
    }
  
    // When the language selector changes, update the codemirror mode
    languageSelector.addEventListener("change", (event) => {
      const language = (event.target as HTMLSelectElement).value;
      setMode(language);
    });
  }
}

// ████████ ██   ██ ███████ ███    ███ ███████     ████████  ██████   ██████   ██████  ██      ███████ 
//    ██    ██   ██ ██      ████  ████ ██             ██    ██    ██ ██       ██       ██      ██      
//    ██    ███████ █████   ██ ████ ██ █████          ██    ██    ██ ██   ███ ██   ███ ██      █████   
//    ██    ██   ██ ██      ██  ██  ██ ██             ██    ██    ██ ██    ██ ██    ██ ██      ██      
//    ██    ██   ██ ███████ ██      ██ ███████        ██     ██████   ██████   ██████  ███████ ███████ 

// Handle the theme toggle button
const themeToggle = document.getElementById("theme-toggle") as HTMLButtonElement | null;
if (themeToggle) {
  function setTheme(theme: "dark" | "light") {
    document.documentElement.classList.remove("dark", "light");
    document.documentElement.classList.add(theme);
    localStorage.setItem("theme", theme);
    if (theme === "dark") {
      if (editor) editor.setOption("theme", "ctp-mocha");
    } else {
      if (editor) editor.setOption("theme", "ctp-latte");
    }
  }

  function toggleTheme() {
    if (document.documentElement.classList.contains("dark")) {
      setTheme("light");
    } else {
      setTheme("dark");
    }
  }

  const currentTheme = localStorage.getItem("theme");
  if (currentTheme && currentTheme === "dark" || currentTheme === "light") {
    setTheme(currentTheme);
  } else {
    const darkThemeMq = window.matchMedia("(prefers-color-scheme: dark)");
    if (darkThemeMq.matches) {
      setTheme("dark");
    } else {
      setTheme("light");
    }
  }

  themeToggle.addEventListener("click", (e) => {
    e.preventDefault();
    toggleTheme();
  });
}