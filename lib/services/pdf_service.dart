import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class PDF {
  getSobreMi() async {
    List? sobreMi = await getSection('Sección de habilidades');
    return sobreMi;
  }

  getProyectos() async {
    List? proyectos = await getSection('Lista de proyectos');
    return proyectos;
  }

  getCertificados() async {
    List? certificados = await getSection('Certificados');
    return certificados;
  }

  Future<void> createPDF({required String saveMethod}) async {

    List? sobreMi = await getSobreMi();
    List? proyectos = await getProyectos();
    List? certificados = await getCertificados();

    String? descripcion = sobreMi?[0]['Descripcion'];

    //List of pdf widgets
    List<pw.Widget> widgets = [];

    //container for profile image decoration
    final divider = pw.Center(
      child: pw.Divider(),
    );

    //add decorated image container to widgets list

    widgets.add(
      pw.SizedBox(
        height: 20,
      ),
    );

    //6. CONTACTO

    widgets.add(
      pw.Text(
        'CONTACTO',
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );

    widgets.add(divider);

    widgets.add(
      pw.SizedBox(
        height: 5,
      ),
    );

    widgets.add(
      pw.Row(
        children: [
          pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColors.blue100,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
            ),
            margin: const pw.EdgeInsets.only(right: 10),
            padding: const pw.EdgeInsets.fromLTRB(7, 5, 7, 5),
            child: pw.UrlLink(
              destination: 'https://github.com/SanRM',
              child: pw.Text(
                'GitHub',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                  color: PdfColors.grey900,
                ),
              ),
            ),
          ),
          pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColors.purple100,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
            ),
            margin: const pw.EdgeInsets.only(right: 10),
            padding: const pw.EdgeInsets.fromLTRB(7, 5, 7, 5),
            child: pw.UrlLink(
              destination:
                  'https://www.linkedin.com/in/SantiagoRodriguezMorales',
              child: pw.Text(
                'LinkedIn',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                  color: PdfColors.grey900,
                ),
              ),
            ),
          ),
          pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColors.pink100,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
            ),
            margin: const pw.EdgeInsets.only(right: 10),
            padding: const pw.EdgeInsets.fromLTRB(7, 5, 7, 5),
            child: pw.Text(
              'Santiagoromom@hotmail.com',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 11,
                color: PdfColors.grey900,
              ),
            ),
          ),
        ],
      ),
    );

    widgets.add(
      pw.SizedBox(
        height: 25,
      ),
    );

    //6. SOBRE MI

    widgets.add(
      pw.Text(
        'SOBRE MI',
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );

    widgets.add(divider);

    widgets.add(
      pw.SizedBox(
        height: 5,
      ),
    );

    widgets.add(
      pw.Container(
        color: PdfColors.grey50,
        child: pw.Text(
          '$descripcion',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey900,
          ),
        ),
      ),
    );

    widgets.add(
      pw.SizedBox(
        height: 25,
      ),
    );

    widgets.add(
      pw.Text(
        'HABILIDADES',
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );

    widgets.add(divider);

    widgets.add(
      pw.SizedBox(
        height: 5,
      ),
    );

    widgets.add(
      pw.Container(
        color: PdfColors.grey50,
        child: pw.Text(
          'Cuento con habilidades y conocimientos en:',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey900,
          ),
        ),
      ),
     
    );

    List<pw.Widget> insigniasWidgets = [];

    for (var i = 0; i < sobreMi?[0]['Insignias'].length; i++) {
      //print(sobreMi?[0]['Insignias'][i]);

      String insignia = sobreMi?[0]['Insignias'][i]['nombre'];

      //print(insignia.length);

      if (insignia != '') {
        insigniasWidgets.add(
          pw.Container(
            //color: PdfColors.red,
            child: pw.Text(
              '\n· $insignia',
              style: const pw.TextStyle(
                //decoration: pw.TextDecoration.underline,
                fontSize: 12,
                color: PdfColors.grey900,
              ),
            ),
          ),
        );
      }
    }

    widgets.add(
      pw.Wrap(
        runSpacing: 0,
        spacing: 10,
        children: insigniasWidgets,
      ),
    );

    //print(insignias);

    //6. PROYECTOS

    widgets.add(
      pw.SizedBox(
        height: 25,
      ),
    );

    widgets.add(
      pw.Text(
        'PROYECTOS',
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );

    widgets.add(divider);

    List<pw.Widget> projectsWidgets = [];

    for (var i = 0; i < proyectos!.length; i++) {
      List<pw.Widget> projectLinksWidgets = [];
      List<pw.Widget> projectLabelsWidgets = [];

      String? projectTitle = proyectos[i]['projectTitle'];
      String? projectDescription = proyectos[i]['projectDescription'];
      List? projectLabels = proyectos[i]['projectLabels'];
      List? projectLinks = proyectos[i]['projectLinks'];

      projectsWidgets.add(
        pw.Container(
          decoration: const pw.BoxDecoration(
            color: PdfColors.cyan50,
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
          ),
          margin: const pw.EdgeInsets.only(top: 10),
          padding: const pw.EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                '$projectTitle',
                style: pw.TextStyle(
                  fontSize: 13,
                  color: PdfColors.grey900,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Text(
                '$projectDescription',
                style: const pw.TextStyle(
                  fontSize: 11,
                  color: PdfColors.grey900,
                ),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                children: projectLabelsWidgets,
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                children: projectLinksWidgets,
              ),
              pw.SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

      if (projectLabels!.isNotEmpty) {
        projectLabelsWidgets.add(
          pw.Text(
            'Tecnologías usadas para realizar este proyecto:',
            style: const pw.TextStyle(
              fontSize: 11,
              color: PdfColors.grey900,
            ),
          ),
        );
      }

      for (var i = 0; i < projectLabels.length; i++) {
        if (projectLabels.isNotEmpty) {
          projectLabelsWidgets.add(
            pw.Container(
              decoration: const pw.BoxDecoration(
                //border: pw.Border.all(color: PdfColors.black),
                color: PdfColors.blue100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
              ),
              margin: const pw.EdgeInsets.symmetric(horizontal: 3),
              padding: const pw.EdgeInsets.fromLTRB(2, 2, 2, 2),
              child: pw.Text(
                ' ${projectLabels[i]} ',
                style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey900,
                    fontWeight: pw.FontWeight.bold),
              ),
            ),
          );
        }
      }

      for (var i = 0; i < projectLinks!.length; i++) {
        if (projectLinks[i] != 0) {
          projectLinksWidgets.add(
            pw.Container(
              decoration: const pw.BoxDecoration(
                color: PdfColors.cyan100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
              ),
              margin: const pw.EdgeInsets.only(right: 10),
              padding: const pw.EdgeInsets.fromLTRB(7, 5, 7, 5),
              child: pw.UrlLink(
                destination: '${projectLinks[i]['url']}',
                child: pw.Text(
                  '${projectLinks[i]['name']}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 11,
                    color: PdfColors.grey900,
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    widgets.add(
      pw.Wrap(
        children: projectsWidgets,
      ),
    );

    widgets.add(
      pw.SizedBox(
        height: 25,
      ),
    );

    widgets.add(
      pw.Text(
        'EDUCACIÓN & CERTIFICADOS',
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );

    widgets.add(divider);

    List<pw.Widget> certificadosWidgets = [];

    for (var i = 0; i < certificados!.length; i++) {
      List<pw.Widget> certificadosLabelsWidgets = [];

      for (var n = 0; n < certificados[i]['labels'].length; n++) {
        certificadosLabelsWidgets.add(
          pw.Container(
            decoration: const pw.BoxDecoration(
              //border: pw.Border.all(color: PdfColors.black),
              color: PdfColors.lightBlue100,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
            ),
            margin: const pw.EdgeInsets.only(right: 5),
            padding: const pw.EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: pw.Text(
              '${certificados[i]['labels'][n]}',
              style: pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey900,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        );
      }

      certificadosWidgets.add(
        pw.Container(
          decoration: const pw.BoxDecoration(
            color: PdfColors.blue50,
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
          ),
          margin: const pw.EdgeInsets.only(top: 10),
          padding: const pw.EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                '${certificados[i]['title']}',
                style: pw.TextStyle(
                  fontSize: 13,
                  color: PdfColors.grey900,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Wrap(
                runSpacing: 5,
                spacing: 5,
                children: certificadosLabelsWidgets,
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Text(
                '${certificados[i]['description']}',
                style: const pw.TextStyle(
                  fontSize: 11,
                  color: PdfColors.grey900,
                ),
              ),
              pw.SizedBox(
                height: 5,
              ),
              certificados[i]['Url'] != ''
                  ? pw.Container(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.blue100,
                        borderRadius:
                            pw.BorderRadius.all(pw.Radius.circular(11)),
                      ),
                      margin: const pw.EdgeInsets.only(right: 10),
                      padding: const pw.EdgeInsets.fromLTRB(7, 5, 7, 5),
                      child: pw.UrlLink(
                        destination: '${certificados[i]['Url']}',
                        child: pw.Text(
                          'Ver certificados digitales',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                            color: PdfColors.grey900,
                          ),
                        ),
                      ),
                    )
                  : pw.Container(),
              pw.SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    }

    widgets.add(
      pw.Wrap(
        spacing: 15,
        children: certificadosWidgets,
      ),
    );

    //pdf document
    final pdf = pw.Document(creator: 'Santiago Rodriguez Morales');
    final fontFamily = Font.ttf(await rootBundle.load("assets/fonts/DMSans-Regular.ttf"));
    final fontFamilyBold = Font.ttf(await rootBundle.load("assets/fonts/DMSans-Bold.ttf"));

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          if (context.pageNumber <= 1) {
            return pw.Center(
              child: pw.Text(
                'SANTIAGO RODRIGUEZ MORALES',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            );
          } else {
            return pw.Text('');
          }
        },
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: fontFamily, bold: fontFamilyBold),
        build: (context) => widgets,
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(bottom: -10),
            child: pw.Text(
              '${context.pageNumber} / ${context.pagesCount}',
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    color: PdfColors.grey800,
                    fontSize: 10,
                  ),
            ),
          );
        },
      ), //here goes the widgets list
    );

    final bytes = await pdf.save();

    switch (saveMethod) {
      case 'web':
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);

        html.AnchorElement(href: url)
          ..target = '_blank'
          ..download =
              'Hoja de vida - Santiago Rodriguez Morales.pdf' // Nombre del archivo
          ..click();

        html.Url.revokeObjectUrl(url);
        break;

      case 'mobile':
        try {
          final dir = await getDownloadsDirectory();
          final filePath =
              '${dir!.path}/Hoja de vida - Santiago Rodriguez Morales.pdf';
          final file = File(filePath);

          await file.writeAsBytes(bytes);

          //print('ruta: $filePath');

          await OpenFilex.open(filePath);

          //print('Archivo guardado correctamente en $filePath');
        } catch (e) {
          //print('Error al abrir el archivo: $e');
        }
        break;
    }
  }
}
