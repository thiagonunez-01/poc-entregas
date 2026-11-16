import { useEffect, useMemo, useState } from 'react'
import DeckGL from '@deck.gl/react'
import { ScatterplotLayer } from '@deck.gl/layers'
import { Map as MapView } from 'react-map-gl/maplibre'
import 'maplibre-gl/dist/maplibre-gl.css'
import { supabase } from './supabase'

const MAP_STYLE = 'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json'
const VIEW = { longitude: -58.5, latitude: -34.6, zoom: 9.3 }
const UMBRAL_DEMORA = 90 // minutos

const COLORES = {
  Pendiente: [224, 161, 0],
  'En camino': [43, 108, 176],
  Entregado: [47, 143, 107],
}

export default function App() {
  const [datos, setDatos] = useState([])
  const [error, setError] = useState(null)

  useEffect(() => {
    supabase
      .from('puntos')
      .select('id, nombre, categoria, latitud, longitud, valor, fecha, descripcion')
      .then(({ data, error }) => {
        console.log('Supabase ->', { data, error })
        if (error) setError(error.message)
        else setDatos(data)
      })
  }, [])

  const kpis = useMemo(() => {
    const total = datos.length
    const promedio = total ? Math.round(datos.reduce((s, d) => s + d.valor, 0) / total) : 0
    const demoradas = datos.filter((d) => d.valor > UMBRAL_DEMORA).length
    return { total, promedio, demoradas }
  }, [datos])

  const layers = [
    new ScatterplotLayer({
      id: 'entregas',
      data: datos,
      pickable: true,
      getPosition: (d) => [d.longitud, d.latitud], // deck.gl: [longitud, latitud]
      getFillColor: (d) => [...(COLORES[d.categoria] ?? [120, 120, 120]), 210],
      getRadius: (d) => 6 + d.valor / 12,
      radiusUnits: 'pixels',
      stroked: true,
      getLineColor: (d) => (d.valor > UMBRAL_DEMORA ? [190, 30, 45] : [255, 255, 255]),
      getLineWidth: (d) => (d.valor > UMBRAL_DEMORA ? 3 : 1),
      lineWidthUnits: 'pixels',
    }),
  ]

  const tooltip = ({ object }) =>
    object && {
      html: `<b>${object.nombre}</b><br/>Categoría: ${object.categoria}<br/>Valor: ${object.valor} min<br/>Zona: ${object.descripcion ?? '-'}`,
      style: { fontSize: '13px', lineHeight: '1.4' },
    }

  return (
    <div className="app">
      <header>
        <h1>Mapa de entregas del AMBA</h1>
        <div className="kpis">
          <Kpi valor={kpis.total} etiqueta="Pedidos registrados" />
          <Kpi valor={`${kpis.promedio} min`} etiqueta="Tiempo promedio de entrega" />
          <Kpi valor={kpis.demoradas} etiqueta={`Entregas demoradas (>${UMBRAL_DEMORA} min)`} alerta />
        </div>
      </header>

      <main>
        <DeckGL initialViewState={VIEW} controller layers={layers} getTooltip={tooltip}>
          <MapView mapStyle={MAP_STYLE} />
        </DeckGL>

        <aside className="leyenda">
          {Object.entries(COLORES).map(([estado, c]) => (
            <div key={estado}>
              <span className="dot" style={{ background: `rgb(${c})` }} /> {estado}
            </div>
          ))}
          <div className="nota">Borde rojo = demorado. Tamaño = minutos.</div>
        </aside>

        {error && <div className="error">No se pudieron cargar los datos: {error}</div>}
      </main>
    </div>
  )
}

function Kpi({ valor, etiqueta, alerta }) {
  return (
    <div className={`kpi${alerta ? ' alerta' : ''}`}>
      <strong>{valor}</strong>
      <span>{etiqueta}</span>
    </div>
  )
}
