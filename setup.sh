#!/bin/bash

# --- Color Definitions for Premium UI ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0;30m' # No Color
RESET='\033[0m'

echo -e "${CYAN}====================================================${RESET}"
echo -e "${GREEN}    🤖 AI-Context Workspace Template Generator 🤖    ${RESET}"
echo -e "${CYAN}====================================================${RESET}"
echo -e "This script initializes a standardized, AI-ready project structure."
echo ""

# 1. Ask for Project Name / Location
read -p "📁 Enter project folder name (leave empty to initialize in current directory): " PROJECT_NAME < /dev/tty

TARGET_DIR="."
if [ ! -z "$PROJECT_NAME" ]; then
    TARGET_DIR="$PROJECT_NAME"
    if [ -d "$TARGET_DIR" ]; then
        echo -e "${YELLOW}⚠️  Directory '$TARGET_DIR' already exists. We will write files inside it.${RESET}"
    else
        mkdir -p "$TARGET_DIR"
        echo -e "${GREEN}✓ Created directory: $TARGET_DIR${RESET}"
    fi
fi

# 2. Choose Tech Stack
echo -e "\n${BLUE}Select your primary technology stack:${RESET}"
echo "  1) Standard / Generic (General Purpose)"
echo "  2) TypeScript / Next.js"
echo "  3) Python (AI/Agent/Data Science)"
echo "  4) Go (Golang)"
read -p "Selection (1-4) [default: 1]: " STACK_CHOICE < /dev/tty

case "$STACK_CHOICE" in
    2)
        STACK_NAME="TypeScript / Next.js"
        LANG_TECH="- Framework/Language: TypeScript, Next.js (App Router)"
        DB_TECH="- Database/State: Supabase / PostgreSQL / Prisma"
        UI_TECH="- Styling/UI: Tailwind CSS, shadcn/ui, Radix UI"
        PREREQS="- Node.js (v18+ or v20+)\n- npm, yarn, or pnpm"
        BUILD_PROC="### Dependency Installation\n\`\`\`bash\nnpm install\n\`\`\`\n\n### Running Dev Server\n\`\`\`bash\nnpm run dev\n\`\`\`\n\n### Production Build\n\`\`\`bash\nnpm run build\n\`\`\`"
        TEST_PROC="- Unit/Integration: Jest or Vitest (\`npm run test\`)\n- E2E Testing: Playwright or Cypress"
        GITIGNORE_EXTRA="node_modules/\n.next/\nout/\nbuild/\n.env.local\n.env.development.local\n.env.test.local\n.env.production.local"
        ;;
    3)
        STACK_NAME="Python (AI/Agent/Data Science)"
        LANG_TECH="- Framework/Language: Python (v3.10+), FastAPI / LangChain / LlamaIndex"
        DB_TECH="- Database/State: PGVector / Pinecone / ChromaDB"
        UI_TECH="- Styling/UI: Streamlit / Gradio (for simple UIs) or headless API"
        PREREQS="- Python 3.10+\n- pip / Poetry / Conda"
        BUILD_PROC="### Virtual Environment Setup\n\`\`\`bash\npython -m venv .venv\nsource .venv/bin/activate  # On Windows: .venv\\\\Scripts\\\\activate\npip install -r requirements.txt\n\`\`\`\n\n### Running Application\n\`\`\`bash\npython main.py\n\`\`\`"
        TEST_PROC="- Testing framework: pytest (\`pytest\`)\n- Linting: ruff or flake8 / black"
        GITIGNORE_EXTRA="__pycache__/\n*.py[cod]\n*$py.class\n.venv/\nvenv/\nENV/\n.env\n.pytest_cache/"
        ;;
    4)
        STACK_NAME="Go (Golang)"
        LANG_TECH="- Framework/Language: Go (v1.20+), Gin / Fiber / Chi"
        DB_TECH="- Database/State: PostgreSQL / SQLX / GORM"
        UI_TECH="- Styling/UI: Headless REST/gRPC API (or templ/HTMX)"
        PREREQS="- Go (v1.20+)"
        BUILD_PROC="### Dependency Download\n\`\`\`bash\ngo mod download\n\`\`\`\n\n### Running Application\n\`\`\`bash\ngo run main.go\n\`\`\`\n\n### Building Binary\n\`\`\`bash\ngo build -o bin/server main.go\n\`\`\`"
        TEST_PROC="- Unit Testing: Go testing framework (\`go test ./...\`)\n- Benchmark: \`go test -bench=.\`"
        GITIGNORE_EXTRA="bin/\n*.exe\n*.exe~\n*.dll\n*.so\n*.dylib\n.env"
        ;;
    *)
        STACK_NAME="Standard / Generic"
        LANG_TECH="- Framework/Language: [Specify, e.g., TypeScript, Next.js, Go]"
        DB_TECH="- Database/State: [Specify, e.g., Supabase, PostgreSQL]"
        UI_TECH="- Styling/UI: [Specify, e.g., Tailwind CSS, shadcn/ui]"
        PREREQS="- Node.js / Go / Python version required.\n- Global CLI tools needed."
        BUILD_PROC="### Setup & Installation\nInstructions on how to install dependencies.\n\n### Build Procedures\nInstructions on how to compile/build the application."
        TEST_PROC="- Unit Testing: Command and framework details.\n- Integration/E2E Testing: Protocols."
        GITIGNORE_EXTRA="node_modules/\n.env\n.DS_Store"
        ;;
esac

# 3. Ask for Git Initialization
read -p "🗂️  Initialize Git repository inside target folder? (y/n) [default: y]: " GIT_CHOICE < /dev/tty
GIT_CHOICE=${GIT_CHOICE:-y}

echo -e "\n${BLUE}🚀 Generating workspace in '${TARGET_DIR}' using stack: ${YELLOW}${STACK_NAME}${RESET}..."

# Create core structure
mkdir -p "$TARGET_DIR/.ai"
mkdir -p "$TARGET_DIR/.well-known"

# Write README.md
cat << EOF > "$TARGET_DIR/README.md"
# $PROJECT_NAME

## Overview
Brief description of the project, its value proposition, and target audience.

## Quick Start
Instructions on how to get the project up and running locally.

## AI-Assisted Development
This project utilizes a structured AI Context layout. For AI agents, LLM crawlers, and advanced IDEs, please refer to \`llms.txt\` and the \`.ai/\` directory for personas, constraints, architectures, and the project ledger.
EOF

# Write llms.txt
cat << EOF > "$TARGET_DIR/llms.txt"
# Project Context & AI Index

## Core Documentation
- [Product Objectives](.ai/objectives.md): Mission, scope, and target audience.
- [Architecture & Rules](.ai/system-prompt.md): Tech stack, coding standards, and constraints.
- [Development Workflow](.ai/development.md): Build, run, and testing protocols.
- [Project Ledger](.ai/changelog.md): Current status, version history, and next steps.

## Repository Structure
- \`.ai/\`: Centralized AI context directory.
- \`src/\`: Main source code.
EOF

cp "$TARGET_DIR/llms.txt" "$TARGET_DIR/.well-known/llms-full.txt"

# Write .env.example
cat << EOF > "$TARGET_DIR/.env.example"
# Environment Variables Template
# Copy this file to .env and populate the values.

NODE_ENV=development
API_BASE_URL=https://api.example.com
DATABASE_URL=your_database_connection_string
EOF

touch "$TARGET_DIR/.env"

# Write .ai/objectives.md
cat << EOF > "$TARGET_DIR/.ai/objectives.md"
# Product Objectives & Scope

## Vision
What problem does this project solve, and why are we building it?

## Core Features
- Feature 1: Description
- Feature 2: Description

## Out of Scope
Explicit boundaries of what the application should NOT do to prevent scope creep.
EOF

# Write .ai/system-prompt.md
cat << EOF > "$TARGET_DIR/.ai/system-prompt.md"
# AI Agent Persona & System Prompt

## Role & Persona
You are an Elite Software Engineer and Software Architect. You write clean, performant, readable, and highly maintainable code. You strictly adhere to the technical stack defined below and maintain robust error handling.

## Technical Stack
$LANG_TECH
$DB_TECH
$UI_TECH

## Coding Standards & Constraints
- Keep components small, modular, and single-purpose.
- Prefer declarative code over imperative code.
- Never write placeholder code or \`// TODO\` comments unless explicitly asked.
- Always validate edge cases and incorporate comprehensive error handling.
EOF

# Write .ai/development.md
cat << EOF > "$TARGET_DIR/.ai/development.md"
# Development Workflow: Build & Testing

## Prerequisites
$(echo -e "$PREREQS")

## Build & Run Procedures
$(echo -e "$BUILD_PROC")

## Testing & Verification
$TEST_PROC
- Verification: AI agents must ensure tests pass before declaring a task complete.
EOF

# Write .ai/changelog.md
cat << EOF > "$TARGET_DIR/.ai/changelog.md"
# Project Ledger & Changelog

## [0.1.0] - Unreleased

### Immediate Next Steps
- [ ] Task 1: Initialize project repository and repository structure.
- [ ] Task 2: Configure environment variables.

### Added
- Initial AI context architecture (\`llms.txt\`, \`.ai/\` schema).
- Basic project configuration templates.
EOF

# Write .gitignore inside target folder
cat << EOF > "$TARGET_DIR/.gitignore"
# Environment variables
.env
.env.local
.env.*.local

# OS files
.DS_Store
Thumbs.db

# Stack-specific ignores
$GITIGNORE_EXTRA
EOF

# Git Initialization
if [[ "$GIT_CHOICE" =~ ^[Yy]$ ]]; then
    if [ "$TARGET_DIR" = "." ]; then
        if [ ! -d ".git" ]; then
            git init
            echo -e "${GREEN}✓ Initialized Git repository in current directory.${RESET}"
        else
            echo -e "${BLUE}ℹ Git repository already initialized.${RESET}"
        fi
    else
        cd "$TARGET_DIR"
        git init
        cd - > /dev/null
        echo -e "${GREEN}✓ Initialized Git repository in '$TARGET_DIR'.${RESET}"
    fi
fi

echo -e "\n${GREEN}✨ Success! AI-Ready project workspace generated successfully. ✨${RESET}"
echo -e "Prompt your AI assistant with the initial instruction found in README.md to begin."