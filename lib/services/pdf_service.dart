import 'package:pdf/pdf.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class PDF {
  getHabilidades() async {
    List? habilidades;
    habilidades = await getSection('Sección de habilidades');
    return habilidades;
  }

  getProyectos() async {
    List? proyectos;
    proyectos = await getSection('Lista de proyectos');
    return proyectos;
  }

  getCertificados() async {
    List? certificados;
    certificados = await getSection('Certificados');
    return certificados;
  }

  Future<void> createPDF() async {
    List? sobreMi = await getHabilidades();
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
            decoration: pw.BoxDecoration(
              color: PdfColors.blue100,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
            ),
            margin: pw.EdgeInsets.only(right: 10),
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
            decoration: pw.BoxDecoration(
              color: PdfColors.purple100,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
            ),
            margin: pw.EdgeInsets.only(right: 10),
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
            decoration: pw.BoxDecoration(
              color: PdfColors.pink100,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
            ),
            margin: pw.EdgeInsets.only(right: 10),
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
        height: 30,
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
      pw.Text(
        '$descripcion',
        style: const pw.TextStyle(
          fontSize: 12,
          color: PdfColors.grey900,
        ),
      ),
    );

    //6. PROYECTOS

    widgets.add(
      pw.SizedBox(
        height: 30,
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

    for (var i = 0; i < proyectos!.length; i++) {
      List<pw.Widget> projectLinksWidgets = [];
      List<pw.Widget> projectLabelsWidgets = [];

      String? projectTitle = proyectos[i]['projectTitle'];
      String? projectDescription = proyectos[i]['projectDescription'];
      List? projectLabels = proyectos[i]['projectLabels'];
      List? projectLinks = proyectos[i]['projectLinks'];

      widgets.add(
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

      if (projectLabels!.length != 0) {
        projectLabelsWidgets.add(
          pw.Text(
            'Tecnologias usadas para realizar este proyecto:',
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.grey900,
            ),
          ),
        );
      }

      for (var i = 0; i < projectLabels.length; i++) {
        if (projectLabels.length != 0) {
          projectLabelsWidgets.add(
            pw.Container(
              decoration: pw.BoxDecoration(
                //border: pw.Border.all(color: PdfColors.black),
                color: PdfColors.blue100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
              ),
              margin: pw.EdgeInsets.symmetric(horizontal: 3),
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
              decoration: pw.BoxDecoration(
                color: PdfColors.cyan100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
              ),
              margin: pw.EdgeInsets.only(right: 10),
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
      pw.SizedBox(
        height: 30,
      ),
    );

    widgets.add(
      pw.Text(
        'CERTIFICADOS',
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );

    widgets.add(divider);

    List<pw.Widget> certificadosWidgets = [];
    List<pw.Widget> certificadosLabelsWidgets = [];


    for (var i = 0; i < certificados!.length; i++) {
      
        certificadosWidgets.add(
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
                pw.Text(
                  '${certificados[i]['title']}',
                  style: pw.TextStyle(
                    fontSize: 13,
                    color: PdfColors.grey900,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${certificados[i]['description']}',
                  style: const pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey900,
                  ),
                ),
                pw.Row(
                  children: certificadosLabelsWidgets,
                ),
              ],
            ),
          ),
        );

        certificadosWidgets.add(
          pw.SizedBox(
            height: 5,
          ),
        );
        
      print(certificados[i]['labels']);

      if (certificados[i] != 0) {
        
        for (var i = 0; i < certificados[i]['labels'].length; i++) {
          certificadosWidgets.add(
            pw.Container(
              decoration: pw.BoxDecoration(
                color: PdfColors.cyan100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(11)),
              ),
              margin: pw.EdgeInsets.only(right: 10),
              padding: const pw.EdgeInsets.fromLTRB(7, 5, 7, 5),
              child: pw.Text(
                '${certificados[i]['labels'][0]}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                  color: PdfColors.grey900,
                ),
              ),
            ),
          );
        }

      }
    }

    widgets.add(
      pw.Wrap(
        spacing: 7,
        runSpacing: 7,
        children: certificadosWidgets,
      ),
    );

    //pdf document
    final pdf = pw.Document(creator: 'Santiago Rodriguez Morales');

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          if (context.pageNumber <= 1) {
            return pw.Center(
              child: pw.Text(
                'Santiago Rodriguez Morales',
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
        build: (context) => widgets,
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Text(
              'Página ${context.pageNumber} de ${context.pagesCount}',
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

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..target = '_blank'
      ..download = 'example.pdf' // Nombre del archivo
      ..click();

    html.Url.revokeObjectUrl(url);
  }
}
