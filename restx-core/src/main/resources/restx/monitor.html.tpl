
<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Restx Monitor</title>
  <link rel="stylesheet" href="http://mleibman.github.com/SlickGrid/slick.grid.css" type="text/css"/>
  <link rel="stylesheet" href="http://mleibman.github.com/SlickGrid/examples/examples.css" type="text/css"/>
</head>
<body style="background: #302E30; ">
  <div style="width:960px; margin-bottom: 5px; margin-left: auto; margin-right: auto; color: #F3F7E4;">Search: <input id="search"></div>
  <div id="myGrid" style="width:960px;height:800px; margin-left: auto; margin-right: auto; "></div>

<script src="http://mleibman.github.com/SlickGrid/lib/jquery-1.7.min.js"></script>
<script src="http://mleibman.github.com/SlickGrid/lib/jquery.event.drag-2.0.min.js"></script>

<script src="http://mleibman.github.com/SlickGrid/slick.core.js"></script>
<script src="http://mleibman.github.com/SlickGrid/slick.grid.js"></script>
<script src="http://mleibman.github.com/SlickGrid/slick.dataview.js"></script>

<script>
  var grid, dataView;
  var columns = [
    {id: "label", name: "Label", field: "label", width: 220, sortable: true},
    {id: "hits", name: "Hits", field: "hits", width: 48, sortable: true},
    {id: "avg", name: "Avg", field: "avg", width: 48, sortable: true},
    {id: "lastVal", name: "Last Value", width: 58, field: "lastVal", sortable: true},
    {id: "min", name: "Min", field: "min", width: 48, sortable: true},
    {id: "max", name: "Max", field: "max", width: 48, sortable: true},
    {id: "active", name: "Active", field: "active", width: 58, sortable: true},
    {id: "avgActive", name: "Avg Active", field: "avgActive", width: 60, sortable: true},
    {id: "maxActive", name: "Max Active", field: "maxActive", width: 60, sortable: true},
    {id: "firstAccess", name: "First Access", field: "firstAccess", width: 120, sortable: true},
    {id: "lastAccess", name: "Last Access", field: "lastAccess", width: 120, sortable: true}
  ];

  var sortcol = "label";
  var sortdir = 1;
  var searchString = "";

  var options = {
    enableCellNavigation: true,
    enableColumnReorder: false
  };

  function comparer(a, b) {
    var x = a[sortcol], y = b[sortcol];
    return (x == y ? 0 : (x > y ? 1 : -1));
  }

  function myFilter(item, args) {
    if (args.searchString != "" && item["label"].indexOf(args.searchString) == -1) {
      return false;
    }

    return true;
  }

  $(function () {
    var data = [
        // { id: 0, label: "BUILD/xxxx xxx xxx", "hits": 8, "avg": 30, "lastVal": 30, "min": 20, "max": 40, "active": 0, "avgActive": 1, "maxActive": 3, "firstAccess": "", "lastAccess": "" },
        {data}
    ];

    dataView = new Slick.Data.DataView({ inlineFilters: true });
    grid = new Slick.Grid("#myGrid", dataView, columns, options);

    grid.onSort.subscribe(function (e, args) {
      sortdir = args.sortAsc ? 1 : -1;
      sortcol = args.sortCol.field;
      dataView.sort(comparer, args.sortAsc);
    });

      dataView.onRowCountChanged.subscribe(function (e, args) {
        grid.updateRowCount();
        grid.render();
      });

      dataView.onRowsChanged.subscribe(function (e, args) {
        grid.invalidateRows(args.rows);
        grid.render();
      });


      $("#search").keyup(function (e) {
          // clear on Esc
          if (e.which == 27) {
            this.value = "";
          }

          searchString = this.value;
          updateFilter();
        });

      function updateFilter() {
          dataView.setFilterArgs({
            searchString: searchString
          });
          dataView.refresh();
        }

      dataView.beginUpdate();
        dataView.setItems(data);
        dataView.setFilterArgs({
          searchString: searchString
        });
        dataView.setFilter(myFilter);
        dataView.endUpdate();
  })
</script>
</body>
</html>