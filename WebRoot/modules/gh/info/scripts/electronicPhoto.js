/**
 * Created by lh on 2014/9/28.
 */
//历史文化列表参数--start
var params = {
    fitColumns: true,
    rownumbers:true,
    // onClickRow: getFactorRow,
    columns: [
        [
            {field: 'ID', title: 'ID', hidden: true, sortable: false, align: 'center', width: 0},
            {
                field: 'OPT',
                title: '操作',
                sortable: false,
                align: 'center',
                width: 180,
                formatter: function (cell, row, index) {
                    var edit = '<a class="btn_edit" href="javascript:void(0);"  onclick="editElectronicPhoto(\'' + row.ID + '\');">修改</a>';
                    var view = '<a class="btn_view" href="javascript:void(0);"  onclick="viewHistory(\'' + row.ID + '\');">预览</a>';
                    var del = '<a class="btn_delete" href="javascript:void(0);"  onclick="delElectronicPhoto(\'' + row.ID + '\');">删除</a>';
                    return  edit+ "&nbsp;" + del;
                }
            },
            {field: 'TITLE', title: '信息标题', sortable: false, align: 'center', width: 420},
            {field: 'TYPE', title: '信息类别', sortable: false, align: 'center', width: 80},
            {field: 'VIEW_TIMES', title: '阅读次数', sortable: false, align: 'center', width: 80},
            {field: 'CREATE_TIME', title: '创建时间', sortable: false, align: 'center', width: 100},
            {field: 'CREATE_USER', title: '创建人', sortable: false, align: 'center', width: 100}
        ]
    ]
};
//电子相册列表参数--end
/**
 * rdcp.JS框架初始化
 */
rdcp.ready(function () {
    //生成表格rdcp.grid(tableId,url,formName,表格参数)
    rdcp.grid('listdt', '!gh/info/~query/Q_ELECTRONIC_PHOTO_LIST', "searchForm", params);

});
//电子相册方法
function addElectronicPhoto(){
    //标签页ID
    var tabId = "addElectronicPhoto";
    //标签页TILE
    var title = "发布信息";
    //标签页url
    var url = "!gh/info/~/pages/electronicPhotoForm.jsp?option=add";
    OpenTab(tabId, title, url);
    //window.open("!property/culturePropaganda/~/pages/addHistory.jsp?option=add");
}
//修改校园文化
function editElectronicPhoto(photo_id){
    //标签页ID
    var tabId = "editElectronicPhoto";
    //标签页TILE
    var title = "修改信息";
    //标签页url
    var url = "!gh/info/~/pages/electronicPhotoForm.jsp?option=edit&photo_id="+photo_id;
    OpenTab(tabId, title, url);
    //window.open("!property/culturePropaganda/~/pages/addHistory.jsp?option=edit&history_id=" + history_id);
}
//删除历史文化
function delElectronicPhoto(photo_id){
    $.messager.confirm("警告", "您确定要删除该条数据吗？",
        function (yesBtn) {
            if(yesBtn) {
                rdcp.request("!gh/info/~query/Q_DEL_ELECTRONIC_PHOTO", "photo_id="+photo_id, function(data){
                    $.messager.alert('提示', "删除成功！", 'info');
                    rdcp.grid.reload('listdt');
                });
            }
    });
    //window.open("!property/culturePropaganda/~/pages/addHistory.jsp?option=edit&history_id=" + history_id);
}

//预览历史文化
function viewHistory(history_id){
    window.open("!property/culturePropaganda/~/pages/previewHistory.jsp?history_id=" + history_id);
}
