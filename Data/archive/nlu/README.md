# NLU Components Archive

This folder contains archived NLU (Natural Language Understanding) components that were part of the original GaiEcom database schema but have been temporarily removed from the main schema.

## Contents

| File | Description |
|------|-------------|
| `nlu_schema.sql` | Database tables, indexes, triggers, and views for NLU support |
| `nlu_seed_data.sql` | Seed data for intents, entities, and synonyms |
| `NLU_DOCUMENTATION.md` | Original documentation for the NLU module |

## When to Re-integrate

These components should be added back when implementing:
- Conversational AI assistant
- Intent-based product search
- User behavior tracking for personalization
- Search analytics and optimization

## Tables Included

- `nlu_intents` - Intent definitions with example utterances
- `nlu_entities` - Named entities (product_type, style, color, room)
- `search_synonyms` - Term synonyms for better search matching
- `conversation_sessions` - Active chat sessions with context
- `conversation_messages` - Message history with detected intents
- `search_logs` - Search queries for analytics
- `user_behavior` - Event tracking for personalization

## Re-integration Steps

1. Run `nlu_schema.sql` after the main schema
2. Load `nlu_seed_data.sql` for initial data
3. Update application code to use NLU tables
4. Refer to `NLU_DOCUMENTATION.md` for integration guide

## Archived On

Date: 2026-01-29
Reason: Focusing on core e-commerce functionality first; NLU to be added in later phase
