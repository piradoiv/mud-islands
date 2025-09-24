#tag Class
Protected Class Island
	#tag Method, Flags = &h0
		Function ConnectedTo() As String()
		  Var result() As String
		  Var ids As New Set
		  
		  For Each zone As MUD.Zone In Zones
		    For Each room As MUD.Room In zone.Rooms
		      If room.IsBoatLocation Then
		        For Each connectedIsland As MUD.Entity In room.ConnectedIslands
		          ids.Add(connectedIsland.Id)
		        Next
		      End If
		    Next
		  Next
		  
		  For Each id As Variant In ids
		    result.Add(id.StringValue)
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mDoors = New Dictionary
		End Sub
	#tag EndMethod

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
		Shared Function FromJSON(input As JSONItem) As MUD.Island
		  Var result As New MUD.Island
		  
		  result.Id = input.Lookup("id", "")
		  result.Name = input.Lookup("name", "Untitled")
		  
		  Var jsonZones As JSONItem = input.Lookup("zones", New JSONItem)
		  For i As Integer = 0 To jsonZones.LastRowIndex
		    Var newZone As MUD.Zone = MUD.Zone.FromJSON(jsonZones.ValueAt(i))
		    newZone.Island = result
		    result.Zones.Add(newZone)
		  Next
		  
		  If input.HasKey("doors") Then
		    Var doorsInput As JSONItem = input.Child("doors")
		    For i As Integer = 0 To doorsInput.LastRowIndex
		      Var newDoor As MUD.Door = MUD.Door.FromJSON(doorsInput.ValueAt(i))
		      result.mDoors.Value(newDoor.Key) = newDoor
		    Next
		  Else
		    For Each zone As MUD.Zone In result.Zones
		      For Each room As MUD.Room In zone.Rooms
		        If room.Exits = Nil Then
		          Continue
		        End If
		        
		        Var exitKeys() As String = room.Exits.Keys
		        For i As Integer = 0 To exitKeys.LastRowIndex
		          Var key As String = exitKeys(i)
		          If Not room.Exits.Value(key) IsA JSONItem Then
		            Continue
		          End If
		          
		          Var roomExit As JSONItem = room.Exits.Child(key)
		          If Not roomExit.HasKey("door") Or roomExit.Value("door") = False Then
		            Continue
		          End If
		          
		          Var door As MUD.Door = MUD.Door.FromJSON(room.Exits.Child(key))
		          Var directions As Dictionary = room.GetDirections
		          result.SetDoorBetweenRooms(room, MUD.Room(directions.Value(key)), door)
		        Next
		        
		        room.Exits = Nil
		      Next
		    Next
		  End If
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoorBetweenRooms(a As MUD.Room, b As MUD.Room) As MUD.Door
		  If a = Nil Or b = Nil Then
		    Return Nil
		  End If
		  
		  Var key As String = DoorKeyForRooms(a, b)
		  If mDoors.HasKey(key) Then
		    Return mDoors.Value(key)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoorsForRoomId(id As String) As MUD.Door()
		  Var result() As MUD.Door
		  
		  For Each entry As DictionaryEntry In mDoors
		    Var door As MUD.Door = entry.Value
		    If door.RoomIds.IndexOf(id) <> -1 Then
		      result.Add(door)
		    End If
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetZoneFromId(id As String) As MUD.Zone
		  For Each zone As MUD.Zone In Zones
		    If zone.Id = id Then
		      Return zone
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MoveRoomToZone(room As MUD.Room, newZoneId As String)
		  Var oldZone As MUD.Zone = room.Zone
		  Var newZone As MUD.Zone = GetZoneFromId(newZoneId)
		  
		  For i As Integer = oldZone.Rooms.LastIndex DownTo 0
		    Var oldRoom As MUD.Room = oldZone.Rooms(i)
		    If oldRoom.X = room.X And oldRoom.Y = room.Y And oldRoom.Z = room.Z Then
		      oldZone.Rooms.RemoveAt(i)
		      Exit For
		    End If
		  Next
		  
		  For i As Integer = 0 To newZone.Rooms.LastIndex
		    Var newZoneRoom As MUD.Room = newZone.Rooms(i)
		    If newZoneRoom.X = room.X And newZoneRoom.Y = room.Y And newZoneRoom.Z = room.Z Then
		      Return
		    End If
		  Next
		  
		  newZone.Rooms.Add(room)
		  room.Zone = newZone
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomAt(x As Integer, y As Integer, z As Integer) As MUD.Room
		  For Each zone As MUD.Zone In Zones
		    For Each room As MUD.Room In Zone.Rooms
		      If room.X = x And room.Y = y And room.Z = z Then
		        Return room
		      End If
		    Next
		  Next
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomCount() As Integer
		  Var result As Integer
		  
		  For Each zone As MUD.Zone In Zones
		    result = result + zone.Rooms.Count
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomExists(x As Integer, y As Integer, z As Integer) As Boolean
		  Return RoomAt(x, y, z) <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RoomHasLadders(x As Integer, y As Integer, z As Integer) As Boolean
		  For Each zone As MUD.Zone In Zones
		    For Each room As MUD.Room In zone.Rooms
		      If room.X = x And room.Y = y And (room.Z = z - 1 Or room.Z = z + 1) Then
		        Return True
		      End If
		    Next
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDoorBetweenRooms(a As MUD.Room, b As MUD.Room, door As MUD.Door)
		  If a = Nil Or b = Nil Then
		    Return
		  End If
		  
		  Var key As String = DoorKeyForRooms(a, b)
		  
		  If door = Nil Then
		    If mDoors.HasKey(key) Then
		      mDoors.Remove(key)
		    End If
		    
		    Return
		  End If
		  
		  door.RoomIds.RemoveAll
		  door.RoomIds.Add(a.Id)
		  door.RoomIds.Add(b.Id)
		  mDoors.Value(key) = door
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  result.Value("id") = Id
		  result.Value("name") = Name
		  
		  Var zonesItem As New JSONItem("[]")
		  For Each zone As MUD.Zone In Zones
		    zonesItem.Add(zone.ToJSON)
		  Next
		  result.Value("zones") = zonesItem
		  
		  Var jsonDoors As New JSONItem("[]")
		  For Each entry As DictionaryEntry In mDoors
		    jsonDoors.Add(MUD.Door(entry.Value).ToJSON)
		  Next
		  result.Value("doors") = jsonDoors
		  
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Id As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDoors As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Zones() As MUD.Zone
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
			Name="Id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
