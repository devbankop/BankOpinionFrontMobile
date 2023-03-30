import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class privacyPolicyView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: 
        
            SingleChildScrollView(
              child:
        Padding(
            padding: EdgeInsets.all(20),
                child: Column(
              children: [
                Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  SizedBox(
                      width: 70.0,
                      height: 70.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(5),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 153, 116, 223),
                            )),
                      )),
                ],
              )),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 20),
                      child: Text("Política de privacidad",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ))),
                        Text("Política de privacidad; El sitio web BankOpinion es propiedad de Ansset Partners S.L, que es un controlador de datos de tus datos personales.; Hemos adoptado esta Política de privacidad, que determina cómo procesamos la información recopilada por BankOpinion, que también proporciona las razones por las que debemos recopilar ciertos datos personales sobre ti. Por lo tanto, debes leer esta Política de privacidad antes de usar el sitio web de BankOpinion.; Cuidamos tus datos personales y nos comprometemos a garantizar su confidencialidad y seguridad.; Información personal que recopilamos:; Cuando visitas BankOpinion, recopilamos bajo su consentimiento cierta información sobre la ubicación del dispositivo para poder mostrar las sucursales cercanas (este servicio puede ser desactivado en la aplicación o desde los ajustes de ubicación el dispositivo. Además, podemos recopilar los datos personales que nos proporcionas (incluidos, entre otros, nombre, apellido, etc.) durante el registro para poder cumplir con el acuerdo.; ¿Por qué procesamos tus datos?; Nuestra máxima prioridad es la seguridad de los datos del cliente y, como tal, podemos procesar solo los datos mínimos del usuario, solo en la medida en que sea absolutamente necesario para mantener el sitio web. La información recopilada automáticamente se utiliza solo para identificar casos potenciales de abuso y establecer información estadística sobre el uso del sitio web. Esta información estadística no se agrega de tal manera que identifique a ningún usuario en particular del sistema.; Puedes visitar la web sin decirnos quién eres ni revelar ninguna información por la cual alguien pueda identificarte como una persona específica. Sin embargo, si deseas utilizar algunas de las funciones del sitio web, o deseas recibir nuestro boletín informativo o proporcionar otros detalles al completar un formulario, puedes proporcionarnos datos personales, como tu correo electrónico, nombre, apellido, ciudad de residencia, organización y número de teléfono. Puedes optar por no proporcionar tus datos personales o ubicación del dispositivo, pero es posible que no puedas aprovechar algunas de las funciones del sitio web. Por ejemplo, no podrás recibir nuestro boletín ni contactarnos directamente desde el sitio web. Los usuarios que no estén seguros de qué información es obligatoria pueden ponerse en contacto con nosotros a través de contacto@bankopinion.com.; Tus derechos:; Si eres residente europeo, tienes los siguientes derechos relacionados con tus datos personales:; •	El derecho a ser informado.; •	El derecho de acceso.; •	El derecho a la rectificación.; •	El derecho a borrar.; •	El derecho a restringir el procesamiento.; •	El derecho a la portabilidad de datos.; •	El derecho a oponerte.; •	Derechos en relación con la toma de decisiones automatizada y la elaboración de perfiles.; Si deseas ejercer este derecho, comunícate con nosotros a través de la información de contacto a continuación.; Además, si eres residente europeo, destacamos que estamos procesando tu información para cumplir con los contratos que podríamos tener contigo (por ejemplo, si realizas un pedido a través de la web), o de otra manera para seguir nuestros intereses comerciales legítimos enumerados anteriormente. Además, ten en cuenta que tu información puede transferirse fuera de Europa, incluidos Canadá y Estados Unidos.; Enlaces a otros sitios web:; Nuestra web puede contener enlaces a otros sitios web que no son de nuestra propiedad ni están controlados por nosotros. Ten en cuenta que no somos responsables de dichos sitios web ni de las prácticas de privacidad de terceros. Te recomendamos que estés atento cuando abandones nuestro sitio web y leas las declaraciones de privacidad de cada web que pueda recopilar información personal.; Seguridad de la información:; Aseguramos la información que proporcionas en servidores informáticos en un entorno controlado y seguro, protegido del acceso, uso o divulgación no autorizados. Mantenemos medidas de seguridad administrativas, técnicas y físicas razonables para proteger contra el acceso no autorizado, el uso, la modificación y la divulgación de datos personales bajo su control y custodia. Sin embargo, no se puede garantizar la transmisión de datos a través de Internet o redes inalámbricas.; Divulgación legal:; Divulgaremos cualquier información que recopilemos, usemos o recibamos si así lo requiere o lo permite la ley, como para cumplir con una citación o un proceso legal similar, y cuando creemos de buena fe que la divulgación es necesaria para proteger nuestros derechos, proteger tu seguridad o la seguridad de los demás, investigar el fraude o responder a una solicitud del gobierno.; Información de contacto:; Si deseas comunicarte con nosotros para comprender más sobre esta Política o deseas comunicarte con nosotros en relación con cualquier asunto sobre los derechos individuales y tu información personal, puedes enviarnos un correo electrónico a contacto@bankopinion.es.")
                    ],
                  )
              ],
            ))));
  }
}
