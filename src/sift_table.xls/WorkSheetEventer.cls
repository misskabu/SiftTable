VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WorkSheetEventer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'�V�[�g�C�x���g���t�b�N���ăC�x���g�𔭐�������N���X
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Public WithEvents workSheetEventer As Application
Attribute workSheetEventer.VB_VarHelpID = -1
'�V�[�g�A�N�e�B�u���̃C�x���g
Private Sub workSheetEventer_SheetActivate(ByVal sh As Object)
    preparedApplication
End Sub
'�G�N�Z���u�b�N���J�������̃C�x���g�B
Private Sub workSheetEventer_WorkbookOpen(ByVal Wb As Workbook)
    preparedApplication
End Sub
'�V�[�g�ɕύX���N����Ɣ�������C�x���g�B
'Intersect�֐��Ń`�F���W�C�x���g�𔭐�������ύX�ӏ������肵�Ă���
Private Sub workSheetEventer_SheetChange(ByVal sh As Object, ByVal Target As Range)
    On Error Resume Next '�����s���̃G���[���o�邪�Ƃ肠���������̂Ŗ������Ă��邪�A���P����ׂ��B
    If Intersect(Target, sh.Range(Cells(10, 2), Cells(41, 2))) Is Nothing Then
        Exit Sub
    Else
        preparedApplication
    End If
End Sub
'�X�^�b�t�N���X�Ȃǂ̏��������s���Ă��顂͂��߂ɂ���𓮂����Ȃ��ƂقƂ�ǂ̃N���X��NULLpointerException�ɂȂ�
Private Sub preparedApplication()
    On Error Resume Next
    TableManager.setTablePosition
End Sub