import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple_dos_lineas.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/paciente_datos_consentimientos_modelo.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/consentimientos/consentimientos_plantilla.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/consentimientos/firmas_paciente.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class DatosConsentPaciente extends StatefulWidget {
  const DatosConsentPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosConsentPaciente> createState() => _DatosConsentPacienteState();
}

class _DatosConsentPacienteState extends State<DatosConsentPaciente> {
  bool ampliarInformeConsentimiento = false;
  bool ampliarPrivacyPolicy = false;
  bool ampliarCientifico = false;
  bool ampliarComercial = false;
  bool ampliarHonor = false;

  bool estadoInformeConsentimiento = false;
  bool estadoPrivacyPolicy = false;
  bool estadoCientifico = false;
  bool estadoComercial = false;
  bool estadoHonor = false;
  //firmas
  String firmaInformedConsent ="";
  String firmaPrivacyPolicy ="";
  String firmaScientificResearch ="";
  String firmaCommercialPurposes ="";
  String firmaHonor ="";

  String nombreArchivo = "";
  String nombreClinica = "";
  String nombrePaciente = "";
  String emailPaciente = "";
  String telPaciente = "";

  //obtener el nombre de la clinica

  Future<void> getNombreClinica() async {
    nombreClinica = await SharedPrefsHelper().getNombreClinica() ?? "";
    print("nombre clinica ${nombreClinica}");
    setState(() {});
  }

  Future<PacienteDatosConsentimientos?> fetchPacienteDatosConsentimientos(
      String idPaciente) async {
    final url = URLProyecto +
        APICarpeta +
        "obtener_datos_consentimientos_paciente_clinica.php"; // URL de tu script PHP

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'id_paciente': idPaciente}, // Parámetros enviados al script PHP
      );

      print(
          "respuesta datos consentimientos paciente clinica --> ${response.body}");
      print(
          "response.statusCode recibido en datos consentimientos paciente clinica --> ${response.statusCode}");

      if (response.statusCode == 200) {
        // Si la solicitud es exitosa, decodifica la respuesta JSON
        final parsed = json.decode(response.body);

        return PacienteDatosConsentimientos.fromJson(parsed);
      } else {
        // Si la solicitud falla, lanza una excepción
        throw Exception('Error al cargar los datos del paciente');
      }
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    nombrePaciente = widget.paciente.nombre!;
    emailPaciente = widget.paciente.email_paciente!;
    telPaciente = widget.paciente.tel_paciente!;

    getNombreClinica();

    refreshData();
  }
  refreshData(){
    fetchPacienteDatosConsentimientos(widget.paciente.id_paciente!)
        .then((pacienteDatosConsentimientos) {
          print("refrescando datos en data consent");
      if (pacienteDatosConsentimientos == null) {
      } else {
        // Procesar los datos del paciente en consent data

        //INFORMED CONSENT FOR TREATMENT
        print("pacienteDatosConsentimientos.statement_honor_no_symtoms_abnormalities ${pacienteDatosConsentimientos.statement_honor_no_symptoms_abnormalities}");
        if (pacienteDatosConsentimientos.informed_consent == "1") {
          estadoInformeConsentimiento = true;
          firmaInformedConsent = URLProyecto+APICarpeta+"firmas/"+pacienteDatosConsentimientos.firma_consent!;
          setState(() {});
        }
        //FIRMA PRIVACY POLICY
        if (pacienteDatosConsentimientos.privacy_policy == "1") {
          estadoPrivacyPolicy = true;
          firmaPrivacyPolicy = URLProyecto+APICarpeta+"firmas/"+pacienteDatosConsentimientos.firma_privacy_policy!;
          setState(() {});
        }
        //FIRMA SCIENTIFIC RESEARCH
        if (pacienteDatosConsentimientos.consent_scientific_research == "1") {
          estadoCientifico = true;
          firmaScientificResearch = URLProyecto+APICarpeta+"firmas/"+pacienteDatosConsentimientos.firma_scientific_research!;
          setState(() {});
        }
        //FIRMA COMMERCIAL RESEARCH
        if (pacienteDatosConsentimientos.consent_commercial_purposes == "1") {
          estadoComercial = true;
          firmaCommercialPurposes = URLProyecto+APICarpeta+"firmas/"+pacienteDatosConsentimientos.firma_commercial_purposes!;
          setState(() {});
        }
        //FIRMA statement of honr
        if (pacienteDatosConsentimientos.statement_honor_no_symptoms_abnormalities == "1") {
          estadoHonor = true;
          firmaHonor = URLProyecto+APICarpeta+"firmas/"+pacienteDatosConsentimientos.firma_statement_honor!;
          setState(() {});
        }
      }
    });

  }


  void _refreshData() {
    // Implementa aquí la lógica para refrescar los datos
    refreshData();
    setState(() {
      // Actualiza el estado del widget con los nuevos datos
      print("estoy en refreshData de data consent");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appPadding),
                  //informed consent
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ampliarInformeConsentimiento =
                            !ampliarInformeConsentimiento;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        estadoInformeConsentimiento
                            ? MiTextoSimple(
                                texto: "InformedConsentforTreatment".tr(),
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontsize: 18)
                            : MiTextoSimple(
                                texto: "InformedConsentforTreatment".tr(),
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontsize: 18),
                      ],
                    ),
                  ),
                  ////informed consent contenido
                  ampliarInformeConsentimiento
                      ? Column(
                          children: [
                            SizedBox(height: appPadding),
                            Text(
                              ConsentTexts.informedConsent(
                                widget.paciente.nombre!,
                                nombreClinica,
                              ),
                              style: AppFonts.nannic(
                                  color: Colors.black54, fontSize: 14),
                            ),
                            SizedBox(height: appPadding),
                            !estadoInformeConsentimiento
                                ? Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                : Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Image.network(
                                firmaInformedConsent,
                                fit: BoxFit.fill, // Ajusta la imagen para cubrir el contenedor
                              ),
                            ),

                            SizedBox(height: appPadding),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignaturePad(
                                              tipoFirma: 'informed_consent',
                                              pacienteId:
                                                  widget.paciente.id_paciente!,
                                            )
                                    ),
                                  ).then((_) {
                                    _refreshData();
                                  });
                                },
                                child: Text('GotoSignaturePad'.tr(),
                                    style: AppFonts.nannic(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),

                  //privacy policy
                  SizedBox(height: appPadding),
                  Divider(),
                  SizedBox(height: appPadding),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ampliarPrivacyPolicy = !ampliarPrivacyPolicy;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        estadoPrivacyPolicy?MiTextoSimple(
                            texto: "PrivacyPolicy".tr(),
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontsize: 18):
                        MiTextoSimple(
                            texto: "PrivacyPolicy".tr(),
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontsize: 18),
                      ],
                    ),
                  ),
                  ////privacy policy contenido
                  ampliarPrivacyPolicy
                      ? Column(
                    children: [
                      SizedBox(height: appPadding),
                      Text(
                        ConsentTexts.privacyPolicy(

                          nombreClinica,
                        ),
                        style: AppFonts.nannic(
                            color: Colors.black54, fontSize: 14),
                      ),
                      SizedBox(height: appPadding),
                      !estadoPrivacyPolicy
                          ? Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 30,
                      )
                          : Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Image.network(
                          firmaPrivacyPolicy,
                          fit: BoxFit.fill, // Ajusta la imagen para cubrir el contenedor
                        ),
                      ),

                      SizedBox(height: appPadding),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignaturePad(
                                    tipoFirma: 'privacy_policy',
                                    pacienteId:
                                    widget.paciente.id_paciente!,
                                  )),
                            ).then((_) {
                              _refreshData();
                            });
                          },
                          child: Text('GotoSignaturePad'.tr(),
                              style: AppFonts.nannic(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                      : Container(
                    height: 0,
                    width: 0,
                  ),

                  //scientic research
                  SizedBox(height: appPadding),
                  Divider(),
                  SizedBox(height: appPadding),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ampliarCientifico = !ampliarCientifico;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        estadoCientifico ? MiTextoSimple(
                            texto: "ConsentforScientificResearch".tr(),
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontsize: 18):
                        MiTextoSimple(
                            texto: "ConsentforScientificResearch".tr(),
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontsize: 18),
                      ],
                    ),
                  ),
                  ampliarCientifico
                      ? Column(
                    children: [
                      SizedBox(height: appPadding),
                      Text(
                        ConsentTexts.consentForScientificResearch(

                          widget.paciente.nombre!,
                        ),
                        style: AppFonts.nannic(
                            color: Colors.black54, fontSize: 14),
                      ),
                      SizedBox(height: appPadding),
                      !estadoCientifico
                          ? Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 30,
                      )
                          : Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Image.network(
                          firmaScientificResearch,
                          fit: BoxFit.fill, // Ajusta la imagen para cubrir el contenedor
                        ),
                      ),

                      SizedBox(height: appPadding),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignaturePad(
                                    tipoFirma: 'scientific_research',
                                    pacienteId:
                                    widget.paciente.id_paciente!,
                                  )),
                            ).then((_) {
                              _refreshData();
                            });
                          },
                          child: Text('GotoSignaturePad'.tr(),
                              style: AppFonts.nannic(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                      : Container(
                    height: 0,
                    width: 0,
                  ),
                  //commercial purposes
                  SizedBox(height: appPadding),
                  Divider(),
                  SizedBox(height: appPadding),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ampliarComercial = !ampliarComercial;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        estadoComercial?MiTextoSimple(
                            texto: "ConsentforCommercialPurposes".tr(),
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontsize: 18):
                        MiTextoSimple(
                            texto: "ConsentforCommercialPurposes".tr(),
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontsize: 18),
                      ],
                    ),
                  ),
                  ampliarComercial
                      ? Column(
                    children: [
                      SizedBox(height: appPadding),
                      Text(
                        ConsentTexts.consentForCommercialPurposes(

                          widget.paciente.nombre!,
                        ),
                        style: AppFonts.nannic(
                            color: Colors.black54, fontSize: 14),
                      ),
                      SizedBox(height: appPadding),
                      !estadoComercial
                          ? Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 30,
                      )
                          : Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Image.network(
                          firmaCommercialPurposes,
                          fit: BoxFit.fill, // Ajusta la imagen para cubrir el contenedor
                        ),
                      ),

                      SizedBox(height: appPadding),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignaturePad(
                                    tipoFirma: 'commercial_purposes',
                                    pacienteId:
                                    widget.paciente.id_paciente!,
                                  )),
                            ).then((_) {
                              _refreshData();
                            });
                          },
                          child: Text('GotoSignaturePad'.tr(),
                              style: AppFonts.nannic(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                      : Container(
                    height: 0,
                    width: 0,
                  ),
                  //statement on honor no symptoms / abnormalities
                  SizedBox(height: appPadding),
                  Divider(),
                  SizedBox(height: appPadding),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ampliarHonor = !ampliarHonor;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        estadoHonor?Container(
                          width: 250,
                          height: 60,
                          child: MiTextoSimpleDosLineas(
                              texto: "StatementonHonorofNoSymptoms/Abnormalities".tr(),
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontsize: 18),
                        ):
                        Container(
                          width: 250,
                          height: 60,
                          child: MiTextoSimpleDosLineas(
                              texto: "StatementonHonorofNoSymptoms/Abnormalities".tr(),
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontsize: 18),
                        ),
                      ],
                    ),
                  ),
                  ampliarHonor
                      ? Column(
                    children: [
                      SizedBox(height: appPadding),
                      Text(
                        ConsentTexts.statementOnHonorOfNoSymptoms(

                          widget.paciente.nombre!,
                        ),
                        style: AppFonts.nannic(
                            color: Colors.black54, fontSize: 14),
                      ),
                      SizedBox(height: appPadding),
                      !estadoHonor
                          ? Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 30,
                      )
                          : Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Image.network(
                          firmaHonor,
                          fit: BoxFit.fill, // Ajusta la imagen para cubrir el contenedor
                        ),
                      ),

                      SizedBox(height: appPadding),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignaturePad(
                                    tipoFirma: 'honor',
                                    pacienteId:
                                    widget.paciente.id_paciente!,
                                  )),
                            ).then((_) {
                              _refreshData();
                            });
                          },
                          child: Text('GotoSignaturePad'.tr(),
                              style: AppFonts.nannic(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                      : Container(
                    height: 0,
                    width: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
