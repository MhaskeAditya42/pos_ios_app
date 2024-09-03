import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/screens/printer_selection_screen.dart';
import 'package:myapp/main.dart';

void main() {
  testWidgets('Menu Live app loads the PrinterSelectionScreen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MenuLiveApp());

    // Verify that PrinterSelectionScreen is displayed.
    expect(find.byType(PrinterSelectionScreen), findsOneWidget);
    
    // Check for any specific widget or text on PrinterSelectionScreen.
    expect(find.text('Select a Printer'), findsOneWidget);  // Assuming this text exists in the PrinterSelectionScreen

    // If there are buttons or other interactions, simulate them here.
    // For example, if there's a button to select a printer, you could simulate a tap:
    // await tester.tap(find.byType(ElevatedButton));  // Update this based on the button's actual type
    // await tester.pump();

    // Verify after interaction.
    // For example, verify if a dialog appears or the screen changes after the button is pressed.
    // expect(find.text('Printer Selected'), findsOneWidget);  // Example verification after interaction
  });
}
