#tag Class
Protected Class Zone
	#tag Method, Flags = &h0
		Shared Function FromJSON(input As JSONItem) As MUD.Zone
		  Var result As New MUD.Zone
		  result.Id = input.Lookup("id", "")
		  Select Case input.Lookup("type", "")
		  Case "pvp"
		    result.Type = Types.PVP
		  Case "pve"
		    result.Type = Types.PVE
		  End Select
		  
		  result.Name = input.Lookup("name", "Untitled")
		  
		  Var rooms As JSONItem = input.Lookup("rooms", New JSONItem)
		  For i As Integer = 0 To rooms.LastRowIndex
		    result.Rooms.Add(MUD.Room.FromJSON(rooms.ValueAt(i)))
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomExists(x As Integer, y As Integer, z As Integer) As Boolean
		  For Each room As MUD.Room In Rooms
		    If room.X = x And room.Y = y And room.Z = z Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomHasLadders(x As Integer, y As Integer, z As Integer) As Boolean
		  For Each room As MUD.Room In Rooms
		    If room.X = x And room.Y = y And (room.Z = z - 1 Or room.Z = z + 1) Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  result.Value("id") = Id
		  Var typeString As String
		  Select Case Type
		  Case Types.PVE
		    typeString = "pve"
		  Case Types.PVP
		    typeString = "pve"
		  End Select
		  result.Value("type") = typeString
		  
		  result.Value("name") = Name
		  
		  Var roomsItem As New JSONItem
		  For Each room As MUD.Room In Rooms
		    roomsItem.Add(room.ToJSON)
		  Next
		  result.Value("rooms") = roomsItem
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ZRange() As Pair
		  Var minZ As Integer
		  Var maxZ As Integer
		  
		  For Each room As MUD.Room In Rooms
		    minZ = Min(minZ, room.Z)
		    maxZ = Max(maxZ, room.Z)
		  Next
		  
		  Return minZ : maxZ
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Id As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Rooms() As MUD.Room
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As MUD.Zone.Types = MUD.Zone.Types.Unknown
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Unknown
		  PVP
		PVE
	#tag EndEnum


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
			Name="Id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="MUD.Zone.Types.Unknown"
			Type="MUD.Zone.Types"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
