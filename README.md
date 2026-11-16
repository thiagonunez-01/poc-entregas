# Mapa de entregas del AMBA (PoC)

Supabase -> React/Vite -> deck.gl -> Vercel

## Correr local
1. `cp .env.example .env` y completar URL y clave publica de Supabase.
2. `npm install`
3. `npm run dev`

## Publicar
Subir a GitHub -> Vercel "Add New Project" -> importar el repo -> en Environment Variables cargar
`VITE_SUPABASE_URL` y `VITE_SUPABASE_ANON_KEY` -> Deploy.
