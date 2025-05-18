-- Verificar e ajustar a tabela profiles
DO $$ 
BEGIN
    -- Verificar se a coluna role existe
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'profiles' 
        AND column_name = 'role'
    ) THEN
        ALTER TABLE profiles ADD COLUMN role TEXT NOT NULL DEFAULT 'user';
    END IF;

    -- Verificar se o trigger de criação de perfil existe
    IF NOT EXISTS (
        SELECT 1 
        FROM pg_trigger 
        WHERE tgname = 'on_auth_user_created'
    ) THEN
        -- Criar função para handle_new_user se não existir
        CREATE OR REPLACE FUNCTION public.handle_new_user()
        RETURNS TRIGGER AS $$
        BEGIN
            INSERT INTO public.profiles (id, username, role)
            VALUES (new.id, new.email, 'user');
            RETURN new;
        END;
        $$ LANGUAGE plpgsql SECURITY DEFINER;

        -- Criar trigger
        CREATE TRIGGER on_auth_user_created
            AFTER INSERT ON auth.users
            FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
    END IF;
END $$;

-- Políticas RLS aprimoradas para cada tabela

-- 1. Profiles (Políticas existentes + novas)
DROP POLICY IF EXISTS "Users can view their own profile" ON profiles;
DROP POLICY IF EXISTS "Users can update their own profile" ON profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can update any profile" ON profiles;

CREATE POLICY "Users can view their own profile"
    ON profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
    ON profiles FOR UPDATE
    USING (auth.uid() = id)
    WITH CHECK (
        auth.uid() = id 
        AND (
            -- Usuários não podem alterar sua própria role
            NEW.role = OLD.role
            -- Outros campos podem ser atualizados
            OR (NEW.role IS NULL AND OLD.role IS NULL)
        )
    );

CREATE POLICY "Admins can view all profiles"
    ON profiles FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

CREATE POLICY "Admins can update any profile"
    ON profiles FOR UPDATE
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- 2. Content Management (Módulos, Pastas, Aulas)
-- Content Modules
DROP POLICY IF EXISTS "Anyone can view content modules" ON content_modules;
DROP POLICY IF EXISTS "Admins can manage content modules" ON content_modules;

CREATE POLICY "Anyone can view content modules"
    ON content_modules FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage content modules"
    ON content_modules FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Content Folders
DROP POLICY IF EXISTS "Anyone can view content folders" ON content_folders;
DROP POLICY IF EXISTS "Admins can manage content folders" ON content_folders;

CREATE POLICY "Anyone can view content folders"
    ON content_folders FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage content folders"
    ON content_folders FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Content Lessons
DROP POLICY IF EXISTS "Anyone can view lessons" ON content_lessons;
DROP POLICY IF EXISTS "Admins can manage lessons" ON content_lessons;

CREATE POLICY "Anyone can view lessons"
    ON content_lessons FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage lessons"
    ON content_lessons FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- 3. User Progress and Interaction
-- User Progress
DROP POLICY IF EXISTS "Users can manage their own progress" ON user_progress;

CREATE POLICY "Users can manage their own progress"
    ON user_progress FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- Lesson Comments
DROP POLICY IF EXISTS "Anyone can view lesson comments" ON lesson_comments;
DROP POLICY IF EXISTS "Users can manage their own comments" ON lesson_comments;
DROP POLICY IF EXISTS "Admins can manage all comments" ON lesson_comments;

CREATE POLICY "Anyone can view lesson comments"
    ON lesson_comments FOR SELECT
    USING (true);

CREATE POLICY "Users can manage their own comments"
    ON lesson_comments FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can manage all comments"
    ON lesson_comments FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- 4. Community Features
-- Forums
DROP POLICY IF EXISTS "Anyone can view forums" ON forums;
DROP POLICY IF EXISTS "Admins can manage forums" ON forums;

CREATE POLICY "Anyone can view forums"
    ON forums FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage forums"
    ON forums FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Forum Posts
DROP POLICY IF EXISTS "Anyone can view forum posts" ON forum_posts;
DROP POLICY IF EXISTS "Users can manage their own posts" ON forum_posts;
DROP POLICY IF EXISTS "Admins can manage all posts" ON forum_posts;

CREATE POLICY "Anyone can view forum posts"
    ON forum_posts FOR SELECT
    USING (true);

CREATE POLICY "Users can manage their own posts"
    ON forum_posts FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can manage all posts"
    ON forum_posts FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- 5. Gamification
-- Challenges
DROP POLICY IF EXISTS "Anyone can view challenges" ON gamification_challenges;
DROP POLICY IF EXISTS "Admins can manage challenges" ON gamification_challenges;

CREATE POLICY "Anyone can view challenges"
    ON gamification_challenges FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage challenges"
    ON gamification_challenges FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- User Challenges
DROP POLICY IF EXISTS "Users can manage their own challenges" ON user_challenges;
DROP POLICY IF EXISTS "Admins can view all user challenges" ON user_challenges;

CREATE POLICY "Users can manage their own challenges"
    ON user_challenges FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can view all user challenges"
    ON user_challenges FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- 6. User Preferences and Notes
-- User Favorites
DROP POLICY IF EXISTS "Users can manage their own favorites" ON user_favorites;

CREATE POLICY "Users can manage their own favorites"
    ON user_favorites FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- User Lesson Notes
DROP POLICY IF EXISTS "Users can manage their own notes" ON user_lesson_notes;

CREATE POLICY "Users can manage their own notes"
    ON user_lesson_notes FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- User AI Playlists
DROP POLICY IF EXISTS "Users can manage their own playlists" ON user_ai_playlists;

CREATE POLICY "Users can manage their own playlists"
    ON user_ai_playlists FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- 7. Badges System
-- Badges
DROP POLICY IF EXISTS "Anyone can view badges" ON badges;
DROP POLICY IF EXISTS "Admins can manage badges" ON badges;

CREATE POLICY "Anyone can view badges"
    ON badges FOR SELECT
    USING (true);

CREATE POLICY "Admins can manage badges"
    ON badges FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- User Badges
DROP POLICY IF EXISTS "Users can view their own badges" ON user_badges;
DROP POLICY IF EXISTS "Admins can manage user badges" ON user_badges;

CREATE POLICY "Users can view their own badges"
    ON user_badges FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Admins can manage user badges"
    ON user_badges FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Função auxiliar para verificar se um usuário é admin
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid() AND role = 'admin'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER; 