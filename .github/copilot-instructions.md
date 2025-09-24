# dubpixel Template GitHub Copilot Instructions

**Version:** 1.0  
**Last Revised:** September 19, 2025

## Ground Rules for AI Assistance

This project includes AI-generated code assistance provided by GitHub Copilot. Please follow these directives to ensure code quality, maintainability, and collaborative development practices.

### Core Principles

- **No modifications to working code without explicit request**
- **Comprehensive commenting of all code and preservation of existing comments** (remove comments that become false/obsolete)
- **Small, incremental changes to maintain code stability**
- **Verification before implementation of any suggestions**
- **Stay focused on the current task** - do not jump ahead or suggest next steps
- **Answer only what is asked** - do not anticipate or propose additional work
- **ALL user prompts and AI solutions must be documented verbatim in the change log comments**
  - Format: User prompt as single line, followed by itemized solution with → bullet

### File Header Comment Standards

All code files should include a comprehensive header comment section with the following format:

```
# ================================================================================
# [FILE TYPE] - [FILE PURPOSE]
# ================================================================================
#
# This project includes AI-generated code assistance provided by GitHub Copilot.
# 
# GitHub Copilot is an AI programming assistant that helps developers write code
# more efficiently by providing suggestions and completing code patterns.
#
# Ground Rules for AI Assistance:
# [Include the core principles above]
#
# The AI assistant will follow these directives to ensure code quality,
# maintainability, and collaborative development practices.
#
# ================================================================================
# PROJECT: dpx_replace_projectName
# ================================================================================
#
# [File-specific information: name, author, purpose, dependencies, etc.]
#
# CHANGE LOG:
# 
# [Document all changes using the established format]
#
# ================================================================================
```

- Use consistent separator lines (80 characters of =)
- Include AI assistance rules in every file
- Maintain change log with verbatim user prompts and solutions
- Use project name placeholder for template replacement

### Documentation Standards

- Maintain comprehensive inline documentation
- Update comments when code changes
- Document all function parameters and return values
- Include usage examples where appropriate
- Keep README files current and accurate, but confirm all changes to the readme file with the user.

### Code Quality Guidelines

- Write clear, readable code with meaningful variable names
- Follow established coding patterns within the project
- Implement proper error handling
- Write testable code with clear interfaces
- Maintain consistent formatting and style

### Change Management

- Make one logical change per modification
- Test changes before suggesting implementation
- Preserve existing functionality unless explicitly asked to change it
- Explain the reasoning behind suggested changes
- Provide rollback information when making significant changes

### Collaboration Standards

- Respect existing architectural decisions
- Ask for clarification when requirements are ambiguous
- Suggest alternatives when appropriate, but don't insist
- Consider the impact of changes on the broader codebase
- Maintain backwards compatibility unless breaking changes are explicitly requested

---

*These instructions help ensure consistent, high-quality AI assistance throughout the development process.*