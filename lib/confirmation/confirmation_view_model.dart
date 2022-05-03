import 'dart:io';
import 'package:framework/shared/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ConfirmationViewModel {
  static Future<File?> generateReceipt(Map<String, int> purchase) async {
    final document = Document();

    document.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Table(
            children: [
                  TableRow(
                    children: [
                      Text(
                        AppLocalizations.translate('product'),
                      ),
                      Text(
                        AppLocalizations.translate('quantity'),
                      ),
                    ],
                  ),
                ] +
                List<TableRow>.generate(
                  purchase.length,
                  (int index) {
                    return TableRow(
                      children: [
                        Text(
                          AppLocalizations.translate(
                              purchase.keys.elementAt(index)),
                        ),
                        Text(
                          purchase.values.elementAt(index).toString(),
                        ),
                      ],
                    );
                  },
                ),
          );
        },
      ),
    );

    try {
      final Directory output = await getApplicationDocumentsDirectory();
      final File file = File("${output.path}/framework.pdf");
      await file.writeAsBytes(await document.save());
      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
