VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CampanyRules"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'�Г��K��i������x�񐔂�J�����ԏ���Ȃǁj���i�[����N���X

'������x��Ԃ����\�b�h
Public Function GetGivenPublicHolidays(���t As Date) As Byte
    Dim �N As Integer
    Dim �� As Integer
    �N = Year(���t)
    �� = Month(���t)
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM ���T�x�� WHERE �N�x = " & �N & "AND  ���x = " & ��)
    On Error Resume Next
    GetGivenPublicHolidays = DatabaseIO.adoRs!���x
    DatabaseIO.DBClose
    Debug.Print "���t="; ���t; "�N="; �N; "��="; ��; "���x="; GetGivenPublicHolidays
End Function
'����T�x��Ԃ����\�b�h
Public Function GetGivenWeeklyHolidays(���t As Date) As Byte
    Dim �N As Integer
    Dim �� As Integer
    �N = Year(���t)
    �� = Month(���t)
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM ���T�x�� WHERE �N�x = " & �N & "AND  ���x = " & ��)
    On Error Resume Next
    GetGivenWeeklyHolidays = DatabaseIO.adoRs!�T�x
    DatabaseIO.DBClose
    Debug.Print "���t="; ���t; "�N="; �N; "��="; ��; "�T�x="; GetGivenWeeklyHolidays
End Function