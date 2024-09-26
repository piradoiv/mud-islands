#tag Class
Protected Class Room
	#tag Method, Flags = &h0
		Shared Function FromJSON(input As JSONItem) As MUD.Room
		  Var result As New Room
		  
		  result.Id = input.Lookup("id", "")
		  result.Name = input.Lookup("name", "")
		  result.Description = input.Lookup("description", "")
		  result.X = input.Lookup("x", 0)
		  result.Y = input.Lookup("y", 0)
		  result.Z = input.Lookup("z", 0)
		  
		  Var exits As JSONItem = input.Lookup("exits", New JSONItem)
		  Var exitIds() As String = Array(exits.Lookup("north", "").StringValue, _
		  exits.Lookup("south", "").StringValue, _
		  exits.Lookup("east", "").StringValue, _
		  exits.Lookup("west", "").StringValue)
		  Var exitEntities() As MUD.Entity
		  For Each exitId As String In exitIds
		    Var emptyEntity As MUD.Entity
		    exitEntities.Add(If(exitId = "", emptyEntity, New MUD.Entity(exitId)))
		  Next
		  result.ExitNorth = exitEntities(0)
		  result.ExitSouth = exitEntities(1)
		  result.ExitEast = exitEntities(2)
		  result.ExitWest = exitEntities(3)
		  
		  Var corpses As JSONItem = input.Lookup("corpses", New JSONItem)
		  For i As Integer = 0 To corpses.LastRowIndex
		    Var corpse As JSONItem = corpses.ValueAt(i)
		    result.NPCs.Add(New MUD.Entity(corpse.Lookup("id", "")))
		  Next
		  
		  Var npcs As JSONItem = input.Lookup("npcs", New JSONItem)
		  For i As Integer = 0 To npcs.LastRowIndex
		    Var npc As JSONItem = npcs.ValueAt(i)
		    result.NPCs.Add(New MUD.Entity(npc.Lookup("id", "")))
		  Next
		  
		  Var enemies As JSONItem = input.Lookup("enemies", New JSONItem)
		  For i As Integer = 0 To enemies.LastRowIndex
		    Var enemy As JSONItem = enemies.ValueAt(i)
		    result.Enemies.Add(New MUD.Entity(enemy.Lookup("id", "")))
		  Next
		  
		  result.IsBoatLocation = input.Lookup("isBoatLocation", False)
		  If result.IsBoatLocation Then
		    Var connectedIslands As JSONItem = input.Value("connectedIslands")
		    For i As Integer = 0 To connectedIslands.LastRowIndex
		      result.ConnectedIslands.Add(New MUD.Entity(connectedIslands.ValueAt(i).StringValue))
		    Next
		  End If
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Var result As New JSONItem
		  
		  result.Value("id") = Id
		  result.Value("name") = Name
		  result.Value("description") = Description
		  result.Value("x") = X
		  result.Value("y") = Y
		  result.Value("z") = Z
		  
		  Var exitsItem As New JSONItem
		  If ExitNorth <> Nil Then
		    exitsItem.Value("north") = ExitNorth.Id
		  End If
		  If ExitSouth <> Nil Then
		    exitsItem.Value("south") = ExitSouth.Id
		  End If
		  If ExitEast <> Nil Then
		    exitsItem.Value("east") = ExitEast.Id
		  End If
		  If ExitWest <> Nil Then
		    exitsItem.Value("west") = ExitWest.Id
		  End If
		  result.Value("exits") = exitsItem
		  
		  Var corpsesItem As New JSONItem
		  For Each corpse As MUD.Entity In Corpses
		    corpsesItem.Add(corpse.ToJSON)
		  Next
		  result.Value("corpses") = corpsesItem
		  
		  Var npcsItem As New JSONItem
		  For Each npc As MUD.Entity In NPCs
		    npcsItem.Add(npc.ToJSON)
		  Next
		  result.Value("npcs") = npcsItem
		  
		  Var enemiesItem As New JSONItem
		  For Each enemy As MUD.Entity In Enemies
		    enemiesItem.Add(enemy.ToJSON)
		  Next
		  result.Value("enemies") = enemiesItem
		  
		  result.Value("isBoatLocation") = IsBoatLocation
		  
		  Var connectedIslandsItem As New JSONItem
		  For Each connectedIsland As MUD.Entity In ConnectedIslands
		    connectedIslandsItem.Add(connectedIsland.Id)
		  Next
		  result.Value("connectedIslands") = connectedIslandsItem
		  
		  Return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ConnectedIslands() As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		Corpses() As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Enemies() As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		ExitEast As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		ExitNorth As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		ExitSouth As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		ExitWest As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		Id As String
	#tag EndProperty

	#tag Property, Flags = &h0
		IsBoatLocation As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		NPCs() As MUD.Entity
	#tag EndProperty

	#tag Property, Flags = &h0
		X As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Y As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Z As Integer
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
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="IsBoatLocation"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="X"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Z"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
