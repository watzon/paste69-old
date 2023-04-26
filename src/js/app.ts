/* eslint no-console:0 */
require("@rails/ujs").start();

// import * as twind from '@twind/core'
// import config from './twind.config'
// twind.install(config)

import "@fortawesome/fontawesome-free/js/all";

import flourite from 'flourite';
import * as monaco from 'monaco-editor';
import rubyLanguage from 'monaco-editor/esm/vs/basic-languages/ruby/ruby';
import zigLanguage from './editor/languages/zig';
import githubLight from './editor/github-light.json';
import githubDark from './editor/github-dark.json';

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
    enabledLanguages: Record<string, string>
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

const editorContainer = document.getElementById("editor") as HTMLDivElement | undefined;
const editorTextArea = document.getElementById("editor-contents") as HTMLTextAreaElement | undefined;
let editor: monaco.editor.IStandaloneCodeEditor;
if (editorContainer && editorTextArea) {
  const startLanguage = (editorContainer.getAttribute("data-language") || "plaintext").toLowerCase();
  const readonlyEditor = !!editorContainer.getAttribute("data-readonly");
  const languageSelector = document.getElementById("language-selector") as HTMLSelectElement | null;

  // Register languages
  monaco.languages.register({ id: 'zig' });
  monaco.languages.setMonarchTokensProvider('zig', zigLanguage as monaco.languages.IMonarchLanguage);
  
  monaco.languages.register({ id: 'crystal' }); // Map to ruby for now
  monaco.languages.setMonarchTokensProvider('crystal', rubyLanguage as monaco.languages.IMonarchLanguage);

  // Set themes
  monaco.editor.defineTheme('github-light', githubLight as monaco.editor.IStandaloneThemeData);
  monaco.editor.defineTheme('github-dark', githubDark as monaco.editor.IStandaloneThemeData);

  // Create model
  const model = monaco.editor.createModel(editorTextArea.value, startLanguage);
  model.onDidChangeContent(() => {
    editorTextArea.value = model.getValue();
  });

  editor = monaco.editor.create(editorContainer, {
    model: model,
    lineNumbers: "on",
    roundedSelection: false,
    scrollBeyondLastLine: true,
    readOnly: readonlyEditor,
    theme: "github-dark",
    fontSize: 18,
    wordWrap: "on",
    autoClosingBrackets: "always",
    minimap: {
      enabled: false
    },
  });

  const setLanguage = (language: string) => {
    monaco.editor.setModelLanguage(model, language);
  }

  // Look for the `data-language` attribute on the editor element. If it's set, use that
  // language instead of trying to detect it.
  const dataLanguage = editorContainer.getAttribute("data-language");
  setLanguage(dataLanguage || "plaintext");

  if (languageSelector) {
    // Add all the enabled languages to the language selector
    for (const [key, value] of Object.entries(enabledLanguages)) {
      const option = document.createElement("option");
      option.value = value;
      option.innerText = key;
      languageSelector.appendChild(option);
    }

    languageSelector.value = dataLanguage || "plaintext";
  
    // When the language selector changes, update the codemirror mode
    languageSelector.addEventListener("change", (event) => {
      const language = (event.target as HTMLSelectElement).value;
      setLanguage(language);
    });
  }
}

// // ████████ ██   ██ ███████ ███    ███ ███████     ████████  ██████   ██████   ██████  ██      ███████ 
// //    ██    ██   ██ ██      ████  ████ ██             ██    ██    ██ ██       ██       ██      ██      
// //    ██    ███████ █████   ██ ████ ██ █████          ██    ██    ██ ██   ███ ██   ███ ██      █████   
// //    ██    ██   ██ ██      ██  ██  ██ ██             ██    ██    ██ ██    ██ ██    ██ ██      ██      
// //    ██    ██   ██ ███████ ██      ██ ███████        ██     ██████   ██████   ██████  ███████ ███████ 

// // Handle the theme toggle button
// const themeToggle = document.getElementById("theme-toggle") as HTMLButtonElement | null;
// if (themeToggle) {
//   function setTheme(theme: "dark" | "light") {
//     document.documentElement.classList.remove("dark", "light");
//     document.documentElement.classList.add(theme);
//     localStorage.setItem("theme", theme);
//     if (theme === "dark") {
//       if (editor) editor.updateOptions({ theme: "github-dark" })
//     } else {
//       if (editor) editor.updateOptions({ theme: "github-light" })
//     }
//   }

//   function toggleTheme() {
//     if (document.documentElement.classList.contains("dark")) {
//       setTheme("light");
//     } else {
//       setTheme("dark");
//     }
//   }

//   const currentTheme = localStorage.getItem("theme");
//   if (currentTheme && currentTheme === "dark" || currentTheme === "light") {
//     setTheme(currentTheme);
//   } else {
//     const darkThemeMq = window.matchMedia("(prefers-color-scheme: dark)");
//     if (darkThemeMq.matches) {
//       setTheme("dark");
//     } else {
//       setTheme("light");
//     }
//   }

//   themeToggle.addEventListener("click", (e) => {
//     e.preventDefault();
//     toggleTheme();
//   });
// }