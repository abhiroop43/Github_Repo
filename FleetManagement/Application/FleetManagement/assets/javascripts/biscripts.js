(function (global) {
    global.OnClientSeriesClicked = function (sender, args) {
        var ajaxManager = global.getAjaxManager();

        if (args.get_seriesName() !== "Months") {
            ajaxManager.ajaxRequest(args.get_category());
        }
    }

    global.OnClientSeriesHovered = function (sender, args) {
        //pie chart item explode//
        //var chart = global.getPieChart1();
        ////get the name of the item that you clicked on
        //var selectedItemName = args.get_category(),
        //itemIndex = -1,
        ////get a reference to the pie series
        //series = chart._chartObject.options.series[0],
        //dataLength = series.data.length;
        //for (var i = 0; i < dataLength; i++) {
        //    //note that the "name" property is defined as a column name in the datasource
        //    //if your original column name is "pieSegmentName", then you should retrieve the value
        //    //with series.data[i].pieSegmentName
        //    var currentItemName = series.data[i].Year;
        //    alert(selectedItemName + " " + currentItemName);
        //    if (currentItemName === selectedItemName) {
        //        itemIndex = i;
        //        alert(itemIndex);
        //    }
        //}

        //if (itemIndex !== -1) {
        //    //find if the item is currently exploded or not
        //    //again, as the property is defined as "isExploded" in the datasource
        //    //we should use the same name
        //    var isExploded = series.data[itemIndex].isExploded;
        //    //change the exploded state
        //    series.data[itemIndex].isExploded = !isExploded;
        //    //repaint the chart to apply the changes
        //    chart.repaint();
        //}
        //var theDataItem = args.get_dataItem();
        //theDataItem.IsExploded = !theDataItem.IsExploded;
        //sender.set_transitions(false);
        //sender.repaint();
        //sender.set_transitions(true);
    }
})(window);