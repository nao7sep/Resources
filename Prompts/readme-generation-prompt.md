# README Generation Prompt

This file contains modular prompts to improve project documentation. Use each section independently or together as needed.

## Overview

Three separate tasks are available:
1. Generate a README.md from project specifications
2. Create a Japanese translation of an existing README
3. Update .csproj file descriptions

IMPORTANT: For ALL tasks, completely ignore any existing content. Generate everything from scratch based solely on the project specification files and source code.

---

## Task 1: Generate README.md

Generate a completely new README.md for this project based on the most recent specification file.

Guidelines:
- IGNORE any existing README.md file - start fresh
- Adapt structure to the specific project needs
- Include relevant sections only (Overview, Features, Configuration, etc.)
- DO NOT include code blocks, class definitions, or identifiers
- DO NOT copy-paste model classes, interfaces, or configuration schemas
- DO NOT include actual content from appsettings.json or other configuration files
- DO NOT explain individual configuration settings in detail
- Summarize technical content in clean prose or bullet points
- For configuration: only mention that configuration exists and what general aspects can be configured
- Explain concepts without showing implementation details
- Use neutral, concise, developer-focused language
- Avoid emojis, badges, and marketing language
- Target audience is developers familiar with .NET ecosystems

If you find yourself wanting to include code samples, configuration details, or class definitions, instead describe what they accomplish and their key properties in plain language.

Focus on clearly communicating the project's purpose, structure, and behavior at a high level. Remember that spec documents contain the internal details - the README should be an overview for new developers.

---

## Task 2: Create Japanese README

Create a completely new README.ja.md based on the generated README.md file.

Guidelines:
- IGNORE any existing README.ja.md file - start fresh
- Use natural Japanese expression, not literal translation
- Preserve all core technical information and meaning
- Adapt content appropriately for Japanese developers
- Create file even if no previous Japanese README existed

---

## Task 3: Update Project Descriptions

Replace ALL Description elements in .csproj files with new concise summaries.

Guidelines:
- IGNORE existing Description content completely - write new descriptions
- Create single-line descriptions (100-150 characters)
- For applications: Focus on purpose and target users
- For libraries: Highlight functionality and capabilities
- For other projects: Emphasize relevant technical aspects
- Use clear, direct language with appropriate terminology
- Focus on technical function rather than marketing
