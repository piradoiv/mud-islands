#tag Class
Protected Class Door
	#tag Method, Flags = &h0
		Shared Function FromJSON(input As JSONItem) As MUD.Door
		  Var result As New MUD.Door
		  
		  result.AutoLock = input.Lookup("auto_lock", True)
		  result.Closed = input.Lookup("closed", True)
		  result.KeyId = input.Lookup("key_id", "")
		  result.Locked = input.Lookup("locked", False)
		  result.LockMessage = input.Lookup("lock_message", False)
		  
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
		KeyId As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Locked As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		LockMessage As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
