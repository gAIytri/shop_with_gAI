-- ============================================================================
-- GaiEcom NLU Assistant Schema Components (Archived)
-- Version: 1.0.0
-- Purpose: NLU tables, indexes, triggers for conversational AI support
-- Status: ARCHIVED - To be integrated in future phase
-- ============================================================================

-- ============================================================================
-- SECTION: NLU ASSISTANT SUPPORT TABLES
-- ============================================================================

-- NLU Intents (for training and logging)
CREATE TABLE nlu_intents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    name VARCHAR(100) UNIQUE NOT NULL,  -- 'search_product', 'check_order_status', 'navigate_category'
    description TEXT,

    -- Example utterances for training
    examples JSONB DEFAULT '[]',
    /*
    [
        "show me modern lamps",
        "I'm looking for lighting",
        "find pendant lights"
    ]
    */

    -- Associated entities
    expected_entities JSONB DEFAULT '[]',  -- ['product_type', 'style', 'room']

    -- Handler info
    handler_function VARCHAR(100),  -- 'handleProductSearch'
    requires_auth BOOLEAN DEFAULT FALSE,

    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- NLU Entities (named entity recognition)
CREATE TABLE nlu_entities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    name VARCHAR(100) UNIQUE NOT NULL,  -- 'product_type', 'style', 'color', 'room'
    description TEXT,
    entity_type VARCHAR(50),  -- 'categorical', 'numeric', 'date', 'free_text'

    -- Possible values and synonyms
    values JSONB DEFAULT '[]',
    /*
    [
        {"value": "pendant", "synonyms": ["pendant light", "hanging light", "pendant lamp"]},
        {"value": "floor lamp", "synonyms": ["standing lamp", "floor light"]}
    ]
    */

    -- For extraction
    patterns JSONB DEFAULT '[]',  -- Regex patterns

    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Product search synonyms (helps NLU)
CREATE TABLE search_synonyms (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    term VARCHAR(100) NOT NULL,
    synonyms JSONB NOT NULL,  -- ["couch", "sofa", "settee", "loveseat"]

    entity_type VARCHAR(50),  -- 'product', 'style', 'color', 'material'

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Conversation sessions (for context)
CREATE TABLE conversation_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    session_token VARCHAR(255) UNIQUE,

    -- Session context
    context JSONB DEFAULT '{}',
    /*
    {
        "current_category": "lighting",
        "filters": {"style": "Modern"},
        "cart_id": "...",
        "last_viewed_products": ["...", "..."]
    }
    */

    -- State
    is_active BOOLEAN DEFAULT TRUE,
    started_at TIMESTAMPTZ DEFAULT NOW(),
    last_activity_at TIMESTAMPTZ DEFAULT NOW(),
    ended_at TIMESTAMPTZ
);

-- Conversation messages (history)
CREATE TABLE conversation_messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id UUID NOT NULL REFERENCES conversation_sessions(id) ON DELETE CASCADE,

    role VARCHAR(20) NOT NULL,  -- 'user', 'assistant', 'system'
    content TEXT NOT NULL,

    -- Parsed intent/entities
    detected_intent VARCHAR(100),
    detected_entities JSONB DEFAULT '{}',
    confidence_score DECIMAL(4,3),

    -- Response metadata
    response_type VARCHAR(50),  -- 'product_list', 'navigation', 'info', 'clarification'
    response_data JSONB,  -- Products shown, links, etc.

    -- Feedback
    was_helpful BOOLEAN,
    feedback_text TEXT,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Search logs (for analytics and improving NLU)
CREATE TABLE search_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    session_id UUID REFERENCES conversation_sessions(id) ON DELETE SET NULL,

    query TEXT NOT NULL,
    normalized_query TEXT,  -- Processed query

    -- What was searched
    search_type VARCHAR(50),  -- 'text', 'voice', 'filter'
    source VARCHAR(50),  -- 'search_bar', 'nlu_assistant', 'navigation'

    -- Results
    result_count INTEGER,
    result_product_ids UUID[],

    -- User action
    clicked_product_id UUID,
    resulted_in_cart BOOLEAN DEFAULT FALSE,
    resulted_in_purchase BOOLEAN DEFAULT FALSE,

    -- Performance
    response_time_ms INTEGER,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- User behavior tracking (for personalization)
CREATE TABLE user_behavior (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    session_id UUID REFERENCES conversation_sessions(id) ON DELETE SET NULL,

    event_type VARCHAR(50) NOT NULL,  -- 'view', 'search', 'add_to_cart', 'purchase', 'wishlist'

    -- Event data
    product_id UUID REFERENCES products(id) ON DELETE SET NULL,
    category_id UUID REFERENCES categories(id) ON DELETE SET NULL,

    event_data JSONB,  -- Additional context

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SECTION: NLU INDEXES
-- ============================================================================

-- NLU / Search indexes
CREATE INDEX idx_search_logs_user ON search_logs(user_id);
CREATE INDEX idx_search_logs_query ON search_logs USING gin(query gin_trgm_ops);
CREATE INDEX idx_search_logs_created ON search_logs(created_at DESC);
CREATE INDEX idx_conversation_sessions_user ON conversation_sessions(user_id);
CREATE INDEX idx_conversation_messages_session ON conversation_messages(session_id);
CREATE INDEX idx_user_behavior_user ON user_behavior(user_id);
CREATE INDEX idx_user_behavior_product ON user_behavior(product_id);

-- ============================================================================
-- SECTION: NLU TRIGGERS
-- ============================================================================

-- Auto-update updated_at for NLU tables
CREATE TRIGGER update_nlu_intents_updated_at BEFORE UPDATE ON nlu_intents
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_nlu_entities_updated_at BEFORE UPDATE ON nlu_entities
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END OF NLU SCHEMA
-- ============================================================================
