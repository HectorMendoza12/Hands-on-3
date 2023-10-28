(deftemplate smartphones
  (slot smart_id)
  (slot marca)
  (multislot modelo)
  (slot color)
  (slot precio)
  (multislot procesador)
  (slot ram)
  (multislot almacenamiento)
)

(deftemplate computadoras
  (slot computadora_id)
  (slot marca)
  (multislot modelo)
  (slot color)
  (slot precio)
  (multislot procesador)
  (slot ram)
  (multislot almacenamiento)
  (multislot tarjetag)
)

(deftemplate accesorios
  (slot accesorio_id)
  (multislot nombre)
  (slot tipo)
  (slot precio)
)

(deftemplate clientes
  (slot cliente_id)
  (multislot nombre)
  (slot genero)
  (multislot telefono)
  (multislot domicilio)
)

(deftemplate orden
  (multislot productos)
  (multislot metodo_pago (default "Efectivo"))
  (multislot forma_pago (default "Contado"))
  (multislot descuentos (default "N/A"))
  (slot promos (default "No"))
  (slot costo_total (default 0))
)

(deftemplate tarjetas
  (multislot banco)
  (multislot grupo)
  (slot fechaexp)
)

(deftemplate vales
  (slot valor)
  (slot fechaexp (default "01-01-25"))
)

(deftemplate costos
  (slot nombre)
  (slot precio)
)
