VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PET/CBM-II Semi-Graphics Generator"
   ClientHeight    =   2790
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   6795
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2790
   ScaleWidth      =   6795
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox cboGen 
      Height          =   315
      ItemData        =   "frmMain.frx":0000
      Left            =   990
      List            =   "frmMain.frx":0016
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   630
      Width           =   3495
   End
   Begin VB.CheckBox cbFull 
      Caption         =   "Generate FULL 256-characters (unckecked gives 128-characters)"
      Height          =   315
      Left            =   180
      TabIndex        =   4
      Top             =   1170
      Width           =   5955
   End
   Begin VB.CommandButton cmdAbout 
      Caption         =   "&About"
      Height          =   795
      Left            =   120
      TabIndex        =   3
      Top             =   1920
      Width           =   1875
   End
   Begin VB.CommandButton cmdStart 
      Caption         =   "&START"
      Height          =   795
      Left            =   2130
      TabIndex        =   2
      Top             =   1920
      Width           =   4605
   End
   Begin VB.TextBox txtOutput 
      Height          =   315
      Left            =   3120
      TabIndex        =   1
      Text            =   "font"
      Top             =   120
      Width           =   1965
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Generate:"
      Height          =   195
      Left            =   180
      TabIndex        =   6
      Top             =   690
      Width           =   705
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "BASE Name of output file (cur directory):"
      Height          =   195
      Left            =   60
      TabIndex        =   0
      Top             =   180
      Width           =   2850
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' SemiGraphicGen V1.0 (C)2016 Steve J. Gray
' =================== Nov 7, 2016. Last update Nov 7, 2016
'
' This program generates different semi-graphic character sets algorithmically
' 1) 8x8 Matrix/8-bits arranged 2 wide by 4 tall (4x2 pixel blocks)
' 2) 8x8 Matrix/8-bits arranged 4 wide by 2 tall (2x4 pixel blocks)
' 3) 8x4 Matrix/8-bits arranged 4 wide by 2 tall in top half only (2x2 pixel blocks)
' 4) 8x4 Matrix/8-bits arranged 4 wide by 2 tall in bottom half only (2x2 pixel blocks)
    
Dim i As Integer
Dim b As Integer
Dim p0 As Integer, p1 As Integer, p2 As Integer, p3 As Integer
Dim p4 As Integer, p5 As Integer, p6 As Integer, p7 As Integer
Dim Max As Integer, Nul As String


Private Sub Form_Load()
    p0 = 1: p1 = 2: p2 = 4: p3 = 8: p4 = 16: p5 = 32: p6 = 64: p7 = 128
    Nul = Chr(0)
    
    cboGen.ListIndex = 0 'set the default gen method drop-down

End Sub

Private Sub cmdAbout_Click()
    MsgBox "ColourPET/CBM-II SemiGraphicGen V1.1, July 14, 2018. (C)2016-2018 Steve J. Gray"
End Sub

Private Sub cmdStart_Click()
   
    Select Case cboGen.ListIndex
        Case 0: Call Gen1(0)
        Case 1: Call Gen1(1)
        Case 2: Call Gen1(2)
        
        Case 3: Call Gen2(0)
        Case 4: Call Gen2(1)
        Case 5: Call Gen2(2)
    End Select
End Sub


'GEN1 - 2x4 in 8x8 or 8x16
'=========================
'MODE 0      MODE 1       MODE 2
'00001111   00001111    00001111
'00001111   00001111    00001111
'22223333   00001111    00001111
'22223333   00001111    00001111
'44445555   22223333    22223333
'44445555   22223333    22223333
'66667777   22223333    22223333
'66667777   44445555    22223333
'           44445555    44445555
'           44445555    44445555
'           44445555    44445555
'           66667777    44445555
'           66667777    66667777
'           66667777    66667777
'           --------    66667777
'           --------    66667777
Sub Gen1(ByVal Mode As Integer)
    
    Max = 127: If cbFull.Value = vbChecked Then Max = 255
    
    '-- Open files with form name as base
    Open txtOutput For Output As 1
    
    For i = 0 To Max
        b = 0 'blocks 0 and 1
        If (i And p0) > 0 Then b = &HF0
        If (i And p1) > 0 Then b = b + &HF
        Print #1, Chr(b); Chr(b);                  'two pixels tall
        If Mode > 0 Then Print #1, Chr(b); Chr(b); 'four pixels tall
        
        b = 0 'blocks 2 and 3
        If (i And p2) > 0 Then b = &HF0
        If (i And p3) > 0 Then b = b + &HF
        Print #1, Chr(b); Chr(b);                   'two pixels tall
        If Mode > 0 Then Print #1, Chr(b);          'three pixels tall
        If Mode > 1 Then Print #1, Chr(b);          'four pixels tall
        
        b = 0 'blocks 4 and 5
        If (i And p4) > 0 Then b = &HF0
        If (i And p5) > 0 Then b = b + &HF
        Print #1, Chr(b); Chr(b);                   'two pixels tall
        If Mode > 0 Then Print #1, Chr(b); Chr(b);  'four pixels tall
        
        b = 0 'blocks 6 and 7
        If (i And p6) > 0 Then b = &HF0
        If (i And p7) > 0 Then b = b + &HF
        Print #1, Chr(b); Chr(b);                   'two pixels tall
        If Mode > 0 Then Print #1, Chr(b);          'three pixels tall
        If Mode > 1 Then Print #1, Chr(b);          'four pixels tall
        
        If Mode = 1 Then Print #1, Nul; Nul;        'two blank lines
    Next i
    
    Close 1
    MsgBox "File sucessfully created!"
    
End Sub

'GEN2 - 4x2 in 8x8 full
'
'MODE 0    Mode 1    Mode 2
'00112233  00112233  xxxxxxxx
'00112233  00112233  xxxxxxxx
'00112233  44556677  xxxxxxxx
'00112233  44556677  xxxxxxxx
'44556677  xxxxxxxx  00112233
'44556677  xxxxxxxx  00112233
'44556677  xxxxxxxx  44556677
'44556677  xxxxxxxx  44556677

Sub Gen2(ByVal Mode As Integer)

    Max = 127: If cbFull.Value = vbChecked Then Max = 255
    
    Open txtOutput For Output As 1
    
    For i = 0 To Max
        If Mode = 2 Then Print #1, Chr(0); Chr(0); Chr(0); Chr(0); '4 blank lines (top)
        
        b = 0 'blocks 0-3
        If (i And p0) > 0 Then b = 192    '128+64
        If (i And p1) > 0 Then b = b + 48 '32+16
        If (i And p2) > 0 Then b = b + 12 '8+4
        If (i And p3) > 0 Then b = b + 3  '2+1
        Print #1, Chr(b); Chr(b); 'two pixels tall
        If Mode = 0 Then Print #1, Chr(b); Chr(b); 'two pixels tall
        
        b = 0 'blocks 4-7
        If (i And p4) > 0 Then b = 192    '128+64
        If (i And p5) > 0 Then b = b + 48 '32+16
        If (i And p6) > 0 Then b = b + 12 '8+4
        If (i And p7) > 0 Then b = b + 3  '2+1
        Print #1, Chr(b); Chr(b); 'two pixels tall
        If Mode = 0 Then Print #1, Chr(b); Chr(b); 'two pixels tall
        
        If Mode = 1 Then Print #1, Chr(0); Chr(0); Chr(0); Chr(0); '4 blank lines (bottom)
    Next i
    
    Close 1
    MsgBox "File sucessfully created!"
    
End Sub


