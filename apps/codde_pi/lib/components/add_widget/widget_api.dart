import 'package:codde_pi/codde_widgets/codde_widgets.dart';

class WidgetApi {
  String name;
  int id;
  WidgetApi({required ControllerClass class_, required this.id})
      : name = toCamelCase(class_.name);

  String get docPath => camelToSpace(name);
  String get funcName => convertCamelToUnderscore(name);

  String getApi() {
    return """
## Example

```python
from codde_protocol import event

@event(server)
def ${funcName}_${id}(*args):
    print("${name} 1", args[0])
```
    """;
  }

  String camelToSpace(String input) {
    // CamelCase
    input = input[0].toUpperCase() + input.substring(1);
    // Insert space (%20) between words
    final RegExp regExp = RegExp(r'(?<=[a-z])([A-Z])');
    String spaced = input.replaceAllMapped(regExp, (Match match) {
      return ' ${match.group(0)!}';
    });

    // S'assurer que la chaîne commence par une lettre minuscule
    if (spaced.startsWith(' ')) {
      spaced = spaced.substring(1);
    }
    print('underscored $spaced');

    return spaced;
  }

  static String toCamelCase(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  String convertCamelToUnderscore(String input) {
    // Utiliser une expression régulière pour trouver les majuscules et les remplacer par un underscore suivi de la lettre en minuscule
    final RegExp regExp = RegExp(r'(?<=[a-z])([A-Z])');
    String underscored = input.replaceAllMapped(regExp, (Match match) {
      return '_${match.group(0)!.toLowerCase()}';
    });

    // S'assurer que la chaîne commence par une lettre minuscule
    if (underscored.startsWith('_')) {
      underscored = underscored.substring(1);
    }

    return underscored.toLowerCase();
  }
}
