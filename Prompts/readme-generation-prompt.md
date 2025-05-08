# README Generation Prompt

This file contains reusable prompts to generate consistent and professional `README.md` files from technical specification documents, translate them to Japanese, and update project descriptions in .csproj files.

## Purpose

Use these prompts with an AI assistant or automation tool to improve project documentation. Each prompt can be used independently or in combination as needed.

## 1. Generate README.md

Generate a clear, professional `README.md` for this project based on the most recent specification file in the directory.

Guidelines:

- Adapt the structure of the README to fit the specific project's needs.
- Include only sections that are appropriate for this application (e.g., Overview, Features, Configuration, How It Works), and omit any that are irrelevant.
- Avoid including code blocks, class definitions, or full configuration dumps — summarize technical content in clean prose or bullet points.
- Maintain a neutral, concise, and developer-focused tone.
- Do not use emojis, badges, marketing phrases, or fluff.
- Assume the reader is a developer familiar with .NET or similar ecosystems.

Focus on clarity, usefulness, and summarizing the purpose, structure, and behavior of the application as described in the specification.

## 2. Create Japanese README Version

Create a Japanese version of the README as "[filename without extension].ja.md" based on the current README.md file.

Guidelines:

- Use natural Japanese expression, not just literal translation
- Preserve all core meaning and technical information
- Adapt content appropriately for Japanese developers
- Overwrite any existing Japanese README if present

## 3. Update Project Descriptions in .csproj Files

Update the Description element in any .csproj files to accurately summarize the project.

Guidelines:

- For applications: Focus on what the application does and its primary use case
- For libraries: Describe the library's purpose, main features, and intended integration scenarios
- For other project types: Provide a concise summary appropriate to the project's nature and purpose
- Use the project content, README, and specification documents as reference
