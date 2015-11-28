<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorLog.aspx.cs" Inherits="FutureAviator.ErrorLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error Log</title>



    <!-- CORE CSS FRAMEWORK - START -->
    <link href="../assets/plugins/pace/pace-theme-flash.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/plugins/bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/fonts/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/animate.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/plugins/perfect-scrollbar/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
    <!-- CORE CSS FRAMEWORK - END -->

    <!-- OTHER SCRIPTS INCLUDED ON THIS PAGE - START -->
    <link href="../assets/plugins/morris-chart/css/morris.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/jquery-ui/smoothness/jquery-ui.min.css" rel="stylesheet" type="text/css" media="screen" />

    <link href="../assets/plugins/rickshaw-chart/css/detail.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/rickshaw-chart/css/legend.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/rickshaw-chart/css/extensions.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/rickshaw-chart/css/rickshaw.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/rickshaw-chart/css/lines.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/jvectormap/jquery-jvectormap-2.0.1.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/icheck/skins/minimal/white.css" rel="stylesheet" type="text/css" media="screen" />

    <!-- OTHER SCRIPTS INCLUDED ON THIS PAGE - END -->

    <!-- Data Table Start -->
    <link href="../assets/plugins/datatables/css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/datatables/extensions/TableTools/css/dataTables.tableTools.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/datatables/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/datatables/extensions/Responsive/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../assets/plugins/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" media="screen" />
    <!-- Data Table Start END -->



    <!-- CORE CSS TEMPLATE - START -->
    <link href="../assets/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/responsive.css" rel="stylesheet" type="text/css" />
    <!-- CORE CSS TEMPLATE - END -->

    <!-- CORE JS FRAMEWORK - START -->
    <script src="../assets/js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../assets/js/jquery.easing.min.js" type="text/javascript"></script>
    <script src="../assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

    <script src="../assets/plugins/perfect-scrollbar/perfect-scrollbar.min.js" type="text/javascript"></script>
    <script src="../assets/plugins/viewport/viewportchecker.js" type="text/javascript"></script>
    <!-- CORE JS FRAMEWORK - END -->

    <!-- OTHER SCRIPTS INCLUDED ON THIS PAGE - END -->

    <script src="../assets/plugins/datatables/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../assets/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js" type="text/javascript"></script>
    <style type="text/css">
        @media screen and (min-width: 768px) {

            #BugDetail .modal-dialog {
                width: 900px;
            }

            #BugDetail .modal-body {
                height: 450px;
            }
        }

        #BugDetail .modal-dialog {
            width: 75%;
        }

        .hide {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">


        <div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
            <section class="box ">
                <header class="panel_header">
                    <h2 class="title pull-left">Bug Log</h2>
                </header>
                <div class="content-body">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <asp:GridView CssClass="table table-striped dt-responsive display MyDataTable" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                                <Columns>

                                    <asp:TemplateField ControlStyle-CssClass="hide" ItemStyle-Width="0%" HeaderText="">
                                        <ItemTemplate>
                                            <%# Convert.ToDateTime(Eval("LogDate")).ToShortDateString() %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="17%" HeaderText="Log Date">
                                        <ItemTemplate>
                                            <%# Eval("LogDate") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>



                                    <asp:TemplateField ItemStyle-Width="20%" HeaderText="Exception URL">
                                        <ItemTemplate>
                                            <%# Eval("ExceptionURL") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField ItemStyle-Width="20%" HeaderText="Error Message">
                                        <ItemTemplate>
                                            <%# Eval("ErrorMessage") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="5%" HeaderText="Tool">
                                        <ItemTemplate>
                                            <div class="form-group">
                                                <a href="javascript:void(0);" onclick="ShowDetail('<%# "#detail-"+ Container.DataItemIndex %>','<%# "#title-"+ Container.DataItemIndex %>')">
                                                    <i class="fa fa-code"></i>
                                                </a>
                                                <div id='<%# "detail-"+ Container.DataItemIndex %>' style="display: none;">
                                                    <pre>
                                                        <%# Eval("TraceStack") %>
                                                    </pre>
                                                </div>

                                                <div id='<%# "title-"+ Container.DataItemIndex %>' style="display: none;">
                                                    <%# Eval("ErrorMessage") %>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>
        </div>



        <div class="modal fade" id="BugDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="large modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="ModalTitle"></h4>
                    </div>
                    <div style="background-color: #ffffcc; overflow: auto;" class="modal-body">
                        <div id="TraceStack"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>

        $(document).ready(function () {
            //  $('.MyDataTable').DataTable();
        });
        function ShowDetail(DetailID, TitleID) {
            $("#TraceStack").html($(DetailID).text());
            $("#ModalTitle").html($(TitleID).text());
            $('#BugDetail').modal('show');
        }



        $(document).ready(function () {
            var table = $('.MyDataTable').DataTable({
                "columnDefs": [
                    { "visible": false, "targets": 0 }
                ],
                "drawCallback": function (settings) {
                    var api = this.api();
                    var rows = api.rows({ page: 'current' }).nodes();
                    var last = null;
                    api.column(0, { page: 'current' }).data().each(function (group, i) {
                        if (last !== group) {
                            $(rows).eq(i).before(
                                '<tr class="group"><td colspan="5"><div style="width: 100%; font-weight: bold; text-align: center; font-size: 19px;">' + group + '</div></td></tr>'
                            );

                            last = group;
                        }
                    });
                }
            });
        });
    </script>
</body>


</html>
