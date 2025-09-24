#tag Class
Protected Class Door
	#tag Method, Flags = &h21
		Private Function DoorKeyForRooms(a As MUD.Room, b As MUD.Room) As String
		  Var first, second As MUD.Room
		  
		  If a.Z > b.Z Then
		    first = a
		    second = b
		  ElseIf b.Z > a.Z Then
		    first = b
		    second = a
		  ElseIf a.Y > b.Y Then
		    first = a
		    second = b
		  ElseIf b.Y > a.Y Then
		    first = b
		    second = a
		  ElseIf a.X > b.X Then
		    first = a
		    second = b
		  Else
		    first = b
		    second = a
		  End If
		  
		  Var xKey As String = "X:" + first.X.ToString + "," + second.X.ToString
		  Var yKey As String = "Y:" + first.Y.ToString + "," + second.Y.ToString
		  Var zKey As String = "Z:" + first.Z.ToString + "," + second.Z.ToString
		  
		  Return xKey + "|" + yKey + "|" + zKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(input As JSONItem) As MUD.Door
		  Var result As New MUD.Door
		  
		  result.IsWall = input.Lookup("is_wall", False)
		  result.AutoLock = input.Lookup("auto_lock", True)
		  result.Closed = input.Lookup("closed", True)
		  result.KeyId = input.Lookup("key_id", "")
		  result.Locked = input.Lookup("locked", False)
		  result.LockMessage = input.Lookup("lock_message", False)
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As String
		  If mRooms.Count = 2 And mRooms(0) <> Nil And mRooms(0).Value <> Nil And mRooms(1) <> Nil And mRooms(1).Value <> Nil Then
		    Return DoorKeyForRooms(MUD.Room(mRooms(0).Value), MUD.Room(mRooms(1).Value))
		  End If
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  result.Value("door") = Not IsWall
		  result.Value("is_wall") = IsWall
		  result.Value("locked") = Locked
		  result.Value("closed") = Closed
		  result.Value("key_id") = KeyId
		  result.Value("lock_message") = LockMessage
		  result.Value("auto_lock") = AutoLock
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToPicture() As WebPicture
		  Return doorclosedfill
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		AutoLock As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Closed As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		IsWall As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		KeyId As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Locked As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		LockMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRooms() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		RoomIds() As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Locked"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Closed"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoLock"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockMessage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWall"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
