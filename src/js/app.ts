/* eslint no-console:0 */
require("@rails/ujs").start();

// import * as twind from '@twind/core'
// import config from './twind.config'
// twind.install(config)

import "@fortawesome/fontawesome-free/js/all";

import flourite from 'flourite';
import CodeMirror from 'codemirror';

import '../css/app.scss';
import { loadCodeMirrorModule, codeMirrorLanguages } from './codemirror/languageModuleLoader';


declare global {
  function copyValue(str: string): void
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

let editor: CodeMirror.Editor;
const editorTextArea = document.getElementById("editor") as HTMLTextAreaElement;
if (editorTextArea) {
  editor = CodeMirror.fromTextArea(editorTextArea, {
    lineNumbers: true,
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
  let timer: NodeJS.Timeout | null = null;
  let langSetManually = false;
  
  function updateMode(editor: CodeMirror.Editor) {
    if (langSetManually) return;
  
    if (timer) {
      clearTimeout(timer);
    }
    timer = setTimeout(() => {
      const mode = flourite(editor.getValue());
      console.log(mode);
      if (mode.language !== "Unknown") {
        loadCodeMirrorModule(mode.language).then(() => {
          editor.setOption("mode", mode.language.toLowerCase());
          if (languageSelector) languageSelector.value = mode.language;
        });
      }
    }, 1000);
  }
  editor.on("change", updateMode);

  // Look for the `data-language` attribute on the editor element. If it's set, use that
  // language instead of trying to detect it.
  const dataLanguage = editorTextArea.getAttribute("data-language");
  if (dataLanguage) {
    loadCodeMirrorModule(dataLanguage).then(() => {
      editor.setOption("mode", dataLanguage.toLowerCase());
      if (languageSelector) languageSelector.value = dataLanguage;
      langSetManually = true;
    });
  }
  
  if (languageSelector) {
    // Add all the languages to the language selector dropdown
    for (const language of Object.keys(codeMirrorLanguages)) {
      const option = document.createElement("option");
      option.value = language;
      option.innerText = language;
      languageSelector.appendChild(option);
    }
  
    // When the language selector changes, update the codemirror mode
    languageSelector.addEventListener("change", (event) => {
      const language = (event.target as HTMLSelectElement).value;
      loadCodeMirrorModule(language).then(() => {
        editor.setOption("mode", language.toLowerCase());
        langSetManually = true;
      });
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