Public Function BlankZero(ByVal Value As Decimal)
    if Value = 0 then
        Return ""
    end if
    Return Value
End Function

Public Function BlankPos(ByVal Value As Decimal)
    if Value > 0 then
        Return ""
    end if
    Return Value
End Function

Public Function BlankZeroAndPos(ByVal Value As Decimal)
    if Value >= 0 then
        Return ""
    end if
    Return Value
End Function

Public Function BlankNeg(ByVal Value As Decimal)
    if Value < 0 then
        Return ""
    end if
    Return Value
End Function

Public Function BlankNegAndZero(ByVal Value As Decimal)
    if Value <= 0 then
        Return ""
    end if
    Return Value
End Function

Shared Data1 as Object
Shared Data2 as Object

Public Function GetData(Num as Integer, Group as integer) as Object
if Group = 1 then
   Return Cstr(Choose(Num, Split(Cstr(Data1),Chr(177))))
End If

if Group = 2 then
   Return Cstr(Choose(Num, Split(Cstr(Data2),Chr(177))))
End If
End Function

Public Function SetData(NewData as Object,Group as integer)
  If Group = 1 and NewData > "" Then
      Data1 = NewData
  End If

  If Group = 2 and NewData > "" Then
      Data2 = NewData
  End If

  Return True
End Function


Shared offset as Integer
public Shared newPage as Object
Shared currentgroup1 as Object
Shared currentCopyNo as Object
Shared currentgroup2 as Integer


Public Function GetGroupPageNumber(NewPage as Boolean, pagenumber as Integer) as Object
 If NewPage then
      offset = pagenumber - 1
  End If
  Return pagenumber - offset
End Function

Public Function IsNewPage(group1 as Object, copyNo as Object) As Boolean
   NewPage = FALSE
   If Not (group1 = currentgroup1 and copyNo=currentCopyNo)
       newPage = TRUE
       currentgroup1 = group1
       currentCopyNo = copyNo
   End if
   Return NewPage
End Function
