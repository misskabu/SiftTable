VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Staff"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'��l���̏]�ƈ�����\���N���X
'���O�A�V�t�g�A�Ј����
'////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Private Enum ��
    ���O�� = 2
    �J�n�� = 3
    �ŏI�� = 39
End Enum
Private Enum �s
    ���t�s = 4
End Enum
Private Enum �E�ʋ敪
    �o�C�g = False
    ���Ј� = True
End Enum
Public row As Integer
'Public ���ԃV�t�g As Collection 'TimeCard�^�̔z�񂪊i�[����Ă���

Public Property Get ���O()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.ActiveSheet
    Dim rg As Range
    Set rg = ws.Cells(row, ��.���O��)
    ���O = rg.Value
End Property
'�����o�ϐ��̖��O���L�[��SQL�𔭍s���ĐE�ʂ𔻕ʂ���
Public Property Get �E��() As Boolean
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O = '" & ���O & "'")
    On Error Resume Next
    �E�� = DatabaseIO.adoRs!����
    DatabaseIO.DBClose
End Property
Public Property Get �o�Εs�j��() As String
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O = '" & ���O & "'")
    On Error Resume Next
    �o�Εs�j�� = DatabaseIO.adoRs!�s�j��
    DatabaseIO.DBClose
End Property
Public Property Get ��]�o�Ή�() As String
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O = '" & ���O & "'")
    On Error Resume Next
    ��]�o�Ή� = DatabaseIO.adoRs!�T����
    DatabaseIO.DBClose
End Property
Public Property Get ���l() As String
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O = '" & ���O & "'")
    On Error Resume Next
    ���l = DatabaseIO.adoRs!���l
    DatabaseIO.DBClose
End Property
Public Property Get ���ԘJ������() As Integer
Application.ScreenUpdating = False
    Dim card As TimeCard
    Dim cnt As Integer
    
    If Me.���O = "" Then
        '���O����̍s�Ȃ̂ŉ��������X�L�b�v����
    Else
        For Each card In Me.���ԃV�t�g
        ProgressForm.SubInfoLabel.Caption = "Scanning....   " & card.���t
        DoEvents
            Select Case �E��
            Case �E�ʋ敪.���Ј�
                If Day(card.���t) = 10 Then
                    cnt = cnt + 1
                End If
                If cnt = 0 Then
                    ���ԘJ������ = ���ԘJ������ + card.�J������
                End If
            Case �E�ʋ敪.�o�C�g
                If Day(card.���t) = 15 Then
                    cnt = cnt + 1
                End If
                If cnt = 1 Then
                    ���ԘJ������ = ���ԘJ������ + card.�J������
                End If
    
            End Select
        Next
    End If
Application.ScreenUpdating = True
End Property
Public Property Get ����() As Long
    On Error Resume Next
    Select Case �E��
    Case �E�ʋ敪.���Ј�
        DatabaseIO.DBConnect
        DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O = '" & ���O & "'")
        ���� = DatabaseIO.adoRs!����
        DatabaseIO.DBClose
    Case �E�ʋ敪.�o�C�g
        DatabaseIO.DBConnect
        DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O = '" & ���O & "'")
        ���� = DatabaseIO.adoRs!���� * ���ԘJ������
        DatabaseIO.DBClose
    End Select
End Property
Public Property Get ����() As Integer
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O = '" & ���O & "'")
    On Error Resume Next
    ���� = DatabaseIO.adoRs!����
    DatabaseIO.DBClose
End Property

Public Property Get ���x��() As Integer
    Dim isClosingDay As Boolean
    Dim card As TimeCard
    ���x�� = 0
    For Each card In Me.���ԃV�t�g
        If Day(card.���t) = 10 Then
            isClosingDay = True
        End If
        If card.�o�Ύ��� = "���x" And isClosingDay = False Then
            ���x�� = ���x�� + 1
        End If
    Next
End Property
Public Property Get �T�x��() As Integer
    Dim isClosingDay As Boolean
    Dim card As TimeCard
    �T�x�� = 0
    For Each card In Me.���ԃV�t�g
        If Day(card.���t) = 10 Then
            isClosingDay = True
        End If
        If card.�o�Ύ��� = "�T�x" And isClosingDay = False Then
            �T�x�� = �T�x�� + 1
        End If
    Next
End Property
'Date�^�̓��t���X�g���i�[�����R���N�V����
Public Property Get �o�Εs�����X�g() As Collection
    Debug.Print Me.���O; ":�o�Εs��="
    Set �o�Εs�����X�g = New Collection
    Dim recordCount As Integer
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT ���t FROM �o�Εs�� WHERE ���O='" & Me.���O & "'")
    recordCount = DatabaseIO.adoRs.recordCount
    Dim i As Integer
    Dim �o�Εs�� As Date
    If recordCount = 0 Then
        Debug.Print "�o�Εs���͂���܂���"
    Else
    For i = 0 To recordCount - 1
        �o�Εs�� = adoRs!���t
        �o�Εs�����X�g.Add �o�Εs��
        adoRs.MoveNext
    Next i
    End If
    DatabaseIO.CloseAdo
    DatabaseIO.DBClose
End Property
'TimeCard�^�̃��X�g���i�[�����R���N�V����
Public Property Get ��{�V�t�g() As Collection
    Set ��{�V�t�g = New Collection
    Dim recordCount As Integer
    DatabaseIO.DBConnect
    DatabaseIO.OpenAdo ("SELECT * FROM �Ј��}�X�^ WHERE ���O='" & Me.���O & "'")
    recordCount = DatabaseIO.adoRs.recordCount
    Dim i As Integer
    Dim ���j�� As TimeCard
    Dim �Ηj�� As TimeCard
    Dim ���j�� As TimeCard
    Dim �ؗj�� As TimeCard
    Dim ���j�� As TimeCard
    Dim �y�j�� As TimeCard
    Dim ���j�� As TimeCard
    Set ���j�� = New TimeCard
    Set �Ηj�� = New TimeCard
    Set ���j�� = New TimeCard
    Set �ؗj�� = New TimeCard
    Set ���j�� = New TimeCard
    Set �y�j�� = New TimeCard
    Set ���j�� = New TimeCard
    
    If recordCount = 0 Then
        Debug.Print "DB�Ɋ�{�V�t�g�������Ă��܂���"
    Else
    For i = 0 To recordCount - 1
    On Error Resume Next '�f�[�^�x�[�X��NULL���������Ă���ƃG���[���������邪�����l�O������Ζ��Ȃ��̂Ŗ�������
        ���j��.�o�Ύ��� = adoRs!���o
        ���j��.�ދΎ��� = adoRs!����
        �Ηj��.�o�Ύ��� = adoRs!�Ώo
        �Ηj��.�ދΎ��� = adoRs!�Α�
        ���j��.�o�Ύ��� = adoRs!���o
        ���j��.�ދΎ��� = adoRs!����
        �ؗj��.�o�Ύ��� = adoRs!�؏o
        �ؗj��.�ދΎ��� = adoRs!�ؑ�
        ���j��.�o�Ύ��� = adoRs!���o
        ���j��.�ދΎ��� = adoRs!����
        �y�j��.�o�Ύ��� = adoRs!�y�o
        �y�j��.�ދΎ��� = adoRs!�y��
        ���j��.�o�Ύ��� = adoRs!���o
        ���j��.�ދΎ��� = adoRs!����
        With ��{�V�t�g
            .Add Item:=���j��, key:="���j��"
            .Add Item:=�Ηj��, key:="�Ηj��"
            .Add Item:=���j��, key:="���j��"
            .Add Item:=�ؗj��, key:="�ؗj��"
            .Add Item:=���j��, key:="���j��"
            .Add Item:=�y�j��, key:="�y�j��"
            .Add Item:=���j��, key:="���j��"
        End With
        adoRs.MoveNext
    Next i
    End If
    DatabaseIO.CloseAdo
    DatabaseIO.DBClose
End Property
'���[�N�V�[�g�ɋL�����ꂽ�V�t�g��[���ԃV�t�g]�Ɋi�[����
Public Property Get ���ԃV�t�g() As Collection
    Dim ws As Worksheet
    Set ws = ThisWorkbook.ActiveSheet
    Dim rg As Range
    Set rg = ws.Cells(row, ��.�J�n��)
    Set ���ԃV�t�g = New Collection
    Dim i As Integer
    For i = ��.�J�n�� To ��.�ŏI��
        Dim �P���V�t�g As TimeCard
        Set �P���V�t�g = New TimeCard
        �P���V�t�g.���t = ws.Cells(�s.���t�s, i).Value
        �P���V�t�g.�o�Ύ��� = ws.Cells(row, i).Value
        �P���V�t�g.�ދΎ��� = ws.Cells(row + 1, i).Value
        ���ԃV�t�g.Add �P���V�t�g
    Next i
End Property
'TimeCard�^�̃��X�g���i�[�����R���N�V����
Public Property Get �O���V�t�g() As Collection
    On Error GoTo catch:
    Set �O���V�t�g = New Collection
    Dim �����V�[�g As Worksheet
    Dim �O���V�[�g As Worksheet
    Set �����V�[�g = ThisWorkbook.ActiveSheet
    Set �O���V�[�g = Worksheets(CheckUtil.PreviousSheetName(�����V�[�g.name))
    Dim rg As Range
    Dim �O���s As Integer
    �O���s = �O���V�[�g.Range("B:B").Find(Me.���O).row
    Set rg = �O���V�[�g.Cells(�O���s, ��.�J�n��)
    Dim i As Integer
    For i = ��.�J�n�� To ��.�ŏI��
        Dim �P���V�t�g As TimeCard
        Set �P���V�t�g = New TimeCard
        �P���V�t�g.���t = �O���V�[�g.Cells(�s.���t�s, i).Value
        �P���V�t�g.�o�Ύ��� = �O���V�[�g.Cells(�O���s, i).Value
        �P���V�t�g.�ދΎ��� = �O���V�[�g.Cells(�O���s + 1, i).Value
        �O���V�t�g.Add �P���V�t�g
    Next i
    Exit Property
catch:
   Debug.Print "�V�[�g�����݂��܂���"
End Property

'�����ɓn���ꂽ���t�̏o�ދΎ��Ԃ�Ԃ�
Public Function getShift(���t_ As Date) As TimeCard
    Dim card As TimeCard
    For Each card In Me.���ԃV�t�g
        If card.���t = ���t_ Then
            Debug.Print card.���t; "�o��:"; card.�o�Ύ���; "�ދ�:"; card.�ދΎ���
            Set getShift = card
        End If
    Next
End Function

