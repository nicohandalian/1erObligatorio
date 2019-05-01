# Primer obligatorio v1.0

El objetivo del obligatorio es desarrollar parte de una aplicación de iOS que servirá para que usuarios realicen pedidos a supermercados.

Consta de dos pantallas:



1) Pantalla principal

Contiene:

● Un carrito en la parte superior derecha que permitirá navegar a la pantalla de checkout.

● Un banner con propagandas sobre artículos destacados.

● Un search que permitirá filtrar el listado de artículos por nombres y categorías.

● Un listado de artículos.

Por defecto todas las celdas del listado tendrán el botón de "Add" visible. Si hay una o más unidades seleccionadas del mismo artículo, se ocultará el botón y se regulará la cantidad de unidades con los botones de "+" y "-



2) Pantalla de checkout

En ella se podrán visualizar los elementos que se encuentran en el carrito de compras antes de confirmarlo. Si no hay elementos en el carrito el botón de checkout debe estar deshabilitado. 

Es importante que independientemente del dispositivo donde se corra la aplicación siempre debe haber dos items por fila. 

Si el usuario toca un item se debe desplegar un picker donde puede modificar la cantidad de unidades. 

Una vez que el usuario presiona "Checkout" deberá desplegarse un alert que le indique al usuario que la compra fue realizada exitosamente, navegar a la pantalla principal y vaciar el carrito de compras.
