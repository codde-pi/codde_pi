part of 'cards.dart';

class CardTasks extends CardBase {
  String data;
  CardTasks(this.data, {super.key});
  @override
  Widget build(context) {
    //TASKS
    var tasks = [];
    String strTasks = data ?? '';
    if (strTasks != '') {
      //print('NOT EMPTY !!!');
      strTasks.split('\n').forEach((value) {
        var array = value.trim().split(' ');
        // print('task = $value');
        //print(array.toString());
        /*tasks.add({
          //'PID': array[0],
          'USER': array[1],
          //'PR': array[2],
          //'NI': array[3],
          //'VIRT': array[4],
          //'RES': array[5],
          //'SHR': array[6],
          //'S': array[7],
          '%CPU': array[8],
          '%MEM': array[9],
          'TIME+': array[10],
          'COMMAND': array[11]
        });*/
        if (array.length > 1) {
          tasks.add({
            'USER': array[1],
            'TIME+': array[2],
            '%CPU': array[3],
            '%MEM': array[4],
            'COMMAND': array[5]
          });
        }
      });
    } else {
      tasks = [
        {"ERROR": "no data", "CAUSE": "unknown"}
      ];
    }

    // print('TASKS => ' + data);

    return Card(
      child: Container(
        height: double.infinity,
        child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior(),
          child: JsonTable(
            tasks,
            allowRowHighlight: true,
            rowHighlightColor: valueColor(context),
            tableHeaderBuilder: (header) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: Theme.of(context).dialogBackgroundColor),
                child: Text(
                  header!,
                  textAlign: TextAlign.center,
                  /*style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700, fontSize: 14.0,color: Colors.black87),*/
                ),
              );
            },
            tableCellBuilder: (value) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Colors.grey.withOpacity(0.5))),
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                  /*style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14.0, color: Colors.grey[900]),*/
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
