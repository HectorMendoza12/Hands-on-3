(defrule oferta-iphone15
  ?orden <- (orden (productos "iPhone 15") (metodo_pago "BBVA VISA") (forma_pago "Contado"))
  =>
  (printout t "¡Oferta especial! Compra un iPhone 15 con tu tarjeta Banamex y obtén 24 meses sin intereses." crlf)
  (modify ?orden (forma_pago "24 Meses sin intereses")))

(defrule oferta-samsungnote12
  ?orden <- (orden (productos "Galaxy Note 12") (metodo_pago "Liverpool VISA") (forma_pago "Contado"))
  =>
  (printout t "¡Oferta especial! Compra un Samsung Galaxy Note 12 con tu tarjeta Liverpool y obtén 12 meses sin intereses." crlf)
  (modify ?orden (forma_pago "12 Meses sin intereses")))

(defrule oferta-vales
  ?b <- (orden (productos $?productos) (forma_pago "Contado") (promos "No"))
  (test (member$ "MacBook Air" ?productos))
  (test (member$ "iPhone15" ?productos))
  =>
  (bind ?total (+ 1399.99 1099.99))
  (bind ?vales (* (/ ?total 1000) 100))
  (assert (vales (valor ?vales)))
  (modify ?b (costo_total ?total) (promos "Vales"))
  (printout t "¡Oferta especial! En la compra de una MacBook Air y un iPhone15 al contado, obtén " ?vales " pesos en vales." crlf))

(defrule funda-mica
  ?b <-(orden (productos ?nombre) (metodo_pago ?metodo) (promos "No"))
  (accesorios (nombre "Mica protectora de pantalla") (precio ?precio-mica))
  (accesorios (nombre "Funda protectora") (precio ?precio-funda))
  (smartphones (modelo ?nombre))
  =>
  (bind ?precio-funda+mica (+ ?precio-funda ?precio-mica))
  (bind ?descuento (* 0.15 ?precio-funda+mica))
  (bind ?total (- ?precio-funda+mica ?descuento))
  (modify ?b (promos "Mica y Funda"))
  (assert (orden (productos "Mica protectora de pantalla" "Funda protectora") (descuentos "15%") (costo_total ?total)))
  (printout t "Por la compra de tu smartphone puedes adquirir una mica y funda con un 15% de descuento siendo un total de $" ?total "."crlf))

(defrule huawei_de_regalo
  ?b <-(orden (productos "P30 Lite") (promos ~"Huawei de regalo"))
  (smartphones (modelo "P30 Lite") (precio ?precio_huawei))
  =>
  (modify ?b (promos "Huawei de regalo") (productos "P30 Lite" "P30 Lite") (costo_total ?precio_huawei))
  (printout t "Por la compra de tu smartphone Huawei P30 Lite se te otorga uno igual sin ningún costo." crlf))

(defrule vaio_descuento
  ?b <-(orden (productos "VAIO") (descuentos "N/A") (promos "No"))
  (computadoras (modelo "VAIO") (precio ?precio))
  =>
  (bind ?descuento (* 0.2 ?precio))
  (bind ?total (- ?precio ?descuento))
  (modify ?b (costo_total ?total) (descuentos "20%") (promos "VAIO Descuento"))
  (printout t "La compra actual por promoción se le aplicará un descuento del 20%, disfruta tu nueva VAIO." crlf))

(defrule octubre_plateado
  ?b <-(orden (productos ?producto) (descuentos "N/A"))
  (computadoras (modelo ?producto) (color "Plateada") (precio ?precio))
  =>
  (bind ?descuento (* 0.3 ?precio))
  (bind ?total (- ?precio ?descuento))
  (modify ?b (costo_total ?total) (descuentos "30%"))
  (printout t "Este octubre todas las computadoras de color plateado tienen un 30% de descuento." crlf))

(defrule festejo_snapdragon
  ?b <- (orden (productos ?producto) (promos "Mica y Funda"))
  (smartphones (modelo ?producto) (procesador "Snapdragon 888"))
  =>
  (modify ?b (promos "Vales Snapdragon"))
  (assert (vales (valor 500.00)))
  (printout t "En la compra de un smartphone con procesador Snapdragon 888 se otorga un vale de $500 pesos." crlf)
)

(defrule promocion-santander
  ?orden <- (orden (productos ?producto) (metodo_pago "Santander Mastercard") (forma_pago "Contado"))
  =>
  (printout t "¡Oferta especial! Compra con tu tarjeta Santander Mastercard y obtén 8 meses sin intereses + monedero electrónico." crlf)
  (modify ?orden (forma_pago "8 Meses sin intereses")))

(defrule mouse-gratis
  ?b <-(orden (productos ?nombre) (metodo_pago "BBVA VISA") (promos "No"))
  (accesorios (nombre "Ratón ergonómico") (precio ?precio))
  (computadoras (modelo ?nombre))
  =>
  (modify ?b (productos ?nombre "Ratón ergonómico") (promos "Mouse gratis"))
  (printout t "En compra de cualquier computadora con una tarjeta BBVA VISA llevate gratis un mouse ergonómico." crlf))

(defrule oferta-auriculares
  ?orden <- (orden (productos "Auriculares Bluetooth") (metodo_pago "Banorte VISA") (forma_pago "Contado"))
  (accesorios (nombre "Auriculares Bluetooth") (precio ?precio))
  =>
  (bind ?descuento (* 0.1 ?precio))
  (bind ?total (- ?precio ?descuento))
  (printout t "En la compra de Auriculares Bluetooth con tu tarjeta Banorte VISA obtén 12 meses sin intereses y un 10% de descuento." crlf)
  (modify ?orden (forma_pago "12 Meses sin intereses") (descuentos "10%") (costo_total ?total)))

(defrule oferta-accesorios-compu
  ?orden <- (orden (productos ?producto) (metodo_pago "Efectivo") (forma_pago "Contado"))
  (accesorios (nombre ?producto) (tipo "Computadora"))
  =>
  (printout t "Todos los accesorios de computadora en compras en efectivo se le otorgan 6 meses sin intereses." crlf)
  (modify ?orden (forma_pago "6 Meses sin intereses") (promos "Accesorios pagados con tarjeta")))

(defrule oferta-productos-apple
  ?orden <- (orden (productos ?producto) (promos ?promo))
  (test (or (eq ?promo "No") (eq ?promo "Mica y Funda")))
  (or (smartphones (modelo ?producto) (marca "Apple") (precio ?precio))
      (computadoras (modelo ?producto) (marca "Apple") (precio ?precio)))
  =>
  (printout t "En la compra de cualquier producto Apple se te otorgan 50 pesos en vales." crlf)
  (assert (vales (valor 50.00)))
  (modify ?orden (promos "Vales $50"))
)

(defrule oferta-productos-lenovo
  ?orden <- (orden (productos ?producto) (promos "No"))
  (computadoras (modelo ?producto) (marca "Lenovo"))
  =>
  (printout t "En la compra de cualquier producto Lenovo se te otorgan 150 pesos en vales." crlf)
  (assert (vales (valor 150.00)))
  (modify ?orden (promos "Vales $150"))
)

(defrule oferta-arcoiris
  ?orden <- (orden (productos ?producto) (promos ~"Promo arcoiris"))
  (smartphones (modelo ?producto) (precio ?precio) (color ?color))
  (test (not (or (eq ?color "Blanco") (eq ?color "Negro") (eq ?color "Gris"))))
  =>
  (bind ?vales (* 0.25 ?precio))
  (assert (vales (valor ?vales)))
  (printout t "Al comprar cualquier smartphone de algún color del arcoiris se te da un vale equivalente al 25% del precio total en vales: " ?vales "." crlf)
  (modify ?orden (promos "Promo arcoiris"))
)

(defrule oferta-galaxy
  ?b <- (orden (productos $?productos) (forma_pago "Contado") (promos ~"Oferta Galaxy"))
  (test (member$ "Galaxy Book" ?productos))
  (test (member$ "Galaxy Note 12" ?productos))
  =>
  (bind ?total (+ 1299.99 1000))
  (bind ?descuento (* 0.15 ?total))
  (bind ?total (- ?total ?descuento))
  (modify ?b (costo_total ?total) (descuentos "15%") (promos "Oferta Galaxy"))
  (printout t "¡Oferta Galaxy! Al comprar dos productos Galaxy de Samsung (computadora y smartphone) se le aplica un descuento al costo total del 15%, siendo un total final de " ?total " pesos." crlf))

(defrule kit-computadora
  ?b <-(orden (productos "Pavilion") (metodo_pago "Banco Azteca Mastercard") (promos "No"))
  (accesorios (nombre "Ratón ergonómico") (precio ?precio))
  (accesorios (nombre "Teclado inalámbrico") (precio ?precio2))
  (computadoras (modelo "Pavilion"))
  =>
  (bind ?precio-total (+ ?precio ?precio2))
  (bind ?descuento (* 0.45 ?precio-total))
  (bind ?total (- ?precio-total ?descuento))
  (modify ?b (promos "HP kit"))
  (assert (orden (productos "Ratón ergonómico" "Teclado inalámbrico") (descuentos "45%") (costo_total ?total)))
  (printout t "HP te consiente, al comprar con tarjetas Banco Azteca puedes llevarte un mouse y teclado con un descuento del 45%: " ?total "." crlf))

(defrule mochila-gratis
  ?b <-(orden (productos "Predator") (promos "No"))
  =>
  (modify ?b (promos "Mochila gratis"))
  (printout t "Al comprar tu mochila Predator obtendrás gratis una mochila para llevarla a todos lados." crlf))

(defrule intelfest
  ?b <- (orden (productos ?producto) (promos ~"Intelfest"))
  (computadoras (modelo ?producto) (procesador ?procesador))
  (test (or (eq ?procesador "Intel i7") (eq ?procesador "Intel i5") (eq ?procesador "Intel i3")))
  =>
  (modify ?b (forma_pago "24 Meses sin intereses") (promos "Intelfest"))
  (printout t "Todas las computadoras con procesador Intel a 24 meses sin intereses." crlf)
)

(defrule tarjetagrafica-meses
  ?orden <- (orden (productos ?producto) (metodo_pago ~"Efectivo") (promos ~"NVIDIA"))
  (computadoras (modelo ?producto) (tarjetag "NVIDIA GeForce RTX 3080"))
  =>
  (printout t "Compra computadoras con tarjeta grafica NVIVIDA RTX 3080 y obtén 12 meses sin intereses en cualquier tarjeta." crlf)
  (modify ?orden (forma_pago "12 Meses sin intereses") (promos "NVIDIA")))

(defrule calcular-total
  ?b <- (orden (productos ?nombre) (costo_total 0))
  (costos (nombre ?nombre) (precio ?precio))
  =>
  (bind ?total (+ 0 ?precio))
  (modify ?b (costo_total ?total))
)




