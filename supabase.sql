-- 1) Tabla
create table if not exists public.puntos (
  id bigint generated always as identity primary key,
  nombre text not null,
  latitud double precision not null,
  longitud double precision not null,
  categoria text not null,      -- estado: Pendiente / En camino / Entregado
  valor integer not null,       -- tiempo de entrega en minutos
  fecha date,
  descripcion text              -- zona
);

-- 2) Permiso de solo lectura para la app (clave publica)
alter table public.puntos enable row level security;
create policy "lectura publica" on public.puntos for select to anon using (true);

-- 3) Datos (alternativa a importar el CSV: usar solo una de las dos opciones)
insert into public.puntos (nombre, latitud, longitud, categoria, valor, fecha, descripcion) values
  ('Pedido 001', -34.59213, -58.39946, 'Entregado', 60, '2026-11-02', 'CABA - Microcentro'),
  ('Pedido 002', -34.61397, -58.39982, 'Entregado', 66, '2026-11-09', 'CABA - Microcentro'),
  ('Pedido 003', -34.59193, -58.39815, 'Entregado', 46, '2026-11-01', 'CABA - Microcentro'),
  ('Pedido 004', -34.60071, -58.40088, 'Entregado', 67, '2026-11-11', 'CABA - Microcentro'),
  ('Pedido 005', -34.5908, -58.39086, 'Entregado', 57, '2026-11-09', 'CABA - Microcentro'),
  ('Pedido 006', -34.60115, -58.37895, 'Entregado', 48, '2026-11-02', 'CABA - Microcentro'),
  ('Pedido 007', -34.59259, -58.4279, 'En camino', 68, '2026-11-04', 'CABA - Palermo'),
  ('Pedido 008', -34.58372, -58.43016, 'Entregado', 64, '2026-11-01', 'CABA - Palermo'),
  ('Pedido 009', -34.59298, -58.44107, 'Entregado', 53, '2026-11-08', 'CABA - Palermo'),
  ('Pedido 010', -34.60305, -58.43879, 'Entregado', 30, '2026-11-04', 'CABA - Palermo'),
  ('Pedido 011', -34.57071, -58.44681, 'Entregado', 39, '2026-11-10', 'CABA - Palermo'),
  ('Pedido 012', -34.53853, -58.47249, 'Entregado', 71, '2026-11-06', 'Vicente López'),
  ('Pedido 013', -34.51559, -58.45799, 'Entregado', 39, '2026-11-10', 'Vicente López'),
  ('Pedido 014', -34.5226, -58.46848, 'Entregado', 28, '2026-11-06', 'Vicente López'),
  ('Pedido 015', -34.51891, -58.49114, 'Entregado', 78, '2026-11-08', 'Vicente López'),
  ('Pedido 016', -34.4657, -58.5063, 'En camino', 23, '2026-11-05', 'San Isidro'),
  ('Pedido 017', -34.47651, -58.50861, 'En camino', 56, '2026-11-11', 'San Isidro'),
  ('Pedido 018', -34.48478, -58.54741, 'Entregado', 77, '2026-11-10', 'San Isidro'),
  ('Pedido 019', -34.45599, -58.52815, 'En camino', 69, '2026-11-07', 'San Isidro'),
  ('Pedido 020', -34.42422, -58.56213, 'Entregado', 84, '2026-11-07', 'Tigre'),
  ('Pedido 021', -34.40849, -58.57096, 'En camino', 84, '2026-11-07', 'Tigre'),
  ('Pedido 022', -34.43857, -58.59325, 'Entregado', 64, '2026-11-04', 'Tigre'),
  ('Pedido 023', -34.43744, -58.5886, 'Entregado', 77, '2026-11-10', 'Tigre'),
  ('Pedido 024', -34.43071, -58.57608, 'Entregado', 95, '2026-11-09', 'Tigre'),
  ('Pedido 025', -34.71442, -58.25245, 'Pendiente', 62, '2026-11-10', 'Quilmes'),
  ('Pedido 026', -34.70928, -58.26774, 'Entregado', 49, '2026-11-11', 'Quilmes'),
  ('Pedido 027', -34.73114, -58.24167, 'Entregado', 90, '2026-11-01', 'Quilmes'),
  ('Pedido 028', -34.72576, -58.28269, 'Entregado', 85, '2026-11-02', 'Quilmes'),
  ('Pedido 029', -34.75591, -58.42391, 'Entregado', 84, '2026-11-06', 'Lomas de Zamora'),
  ('Pedido 030', -34.77265, -58.4159, 'Entregado', 86, '2026-11-07', 'Lomas de Zamora'),
  ('Pedido 031', -34.74225, -58.4065, 'Entregado', 73, '2026-11-08', 'Lomas de Zamora'),
  ('Pedido 032', -34.77281, -58.39401, 'Entregado', 86, '2026-11-02', 'Lomas de Zamora'),
  ('Pedido 033', -34.71717, -58.54016, 'En camino', 67, '2026-11-09', 'La Matanza'),
  ('Pedido 034', -34.69316, -58.54178, 'Entregado', 98, '2026-11-03', 'La Matanza'),
  ('Pedido 035', -34.69294, -58.57051, 'En camino', 87, '2026-11-02', 'La Matanza'),
  ('Pedido 036', -34.70519, -58.5722, 'Entregado', 119, '2026-11-03', 'La Matanza'),
  ('Pedido 037', -34.68879, -58.53866, 'Entregado', 69, '2026-11-10', 'La Matanza'),
  ('Pedido 038', -34.64154, -58.60845, 'Pendiente', 69, '2026-11-04', 'Morón'),
  ('Pedido 039', -34.63537, -58.60623, 'Entregado', 53, '2026-11-01', 'Morón'),
  ('Pedido 040', -34.64607, -58.59891, 'Entregado', 68, '2026-11-04', 'Morón'),
  ('Pedido 041', -34.6681, -58.63651, 'Entregado', 119, '2026-11-06', 'Morón'),
  ('Pedido 042', -34.46964, -58.90854, 'Entregado', 104, '2026-11-06', 'Pilar'),
  ('Pedido 043', -34.46462, -58.9077, 'Pendiente', 136, '2026-11-11', 'Pilar'),
  ('Pedido 044', -34.44425, -58.90158, 'En camino', 107, '2026-11-02', 'Pilar'),
  ('Pedido 045', -34.46503, -58.90076, 'En camino', 113, '2026-11-11', 'Pilar'),
  ('Pedido 046', -34.46033, -58.90329, 'Pendiente', 126, '2026-11-07', 'Pilar'),
  ('Pedido 047', -34.36256, -58.77219, 'Entregado', 145, '2026-11-01', 'Escobar'),
  ('Pedido 048', -34.34598, -58.78578, 'En camino', 162, '2026-11-03', 'Escobar'),
  ('Pedido 049', -34.36328, -58.81137, 'Entregado', 124, '2026-11-09', 'Escobar'),
  ('Pedido 050', -34.3643, -58.77902, 'Pendiente', 110, '2026-11-11', 'Escobar');
