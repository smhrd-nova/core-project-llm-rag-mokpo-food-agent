# 🤖 Ollama 기반 Local LLM 연동

## 📅 Development Date

2026-09-03

---

## 1. Development Purpose

기존 Node.js + Express 기반 웹서비스에
로컬 환경에서 실행되는 Ollama LLM을 연동하였다.

기존 `/api/chat` API는 Demo Fallback 방식으로 동작하고 있었으나,
이번 개발을 통해 로컬 Ollama의 `gemma4:26b` 모델을 호출할 수 있도록
LLM Provider를 연결하였다.

이를 통해 향후 Local DB, RAG, Tavily Search 및 AI Agent를
단계적으로 결합할 수 있는 기반을 구축하였다.

---

## 2. Development Environment

- Node.js
- Express
- Ollama
- Gemma 4 26B
- HTML
- CSS
- JavaScript

### Local LLM

```text
Provider : Ollama
Model    : gemma4:26b
Endpoint : http://127.0.0.1:11434
