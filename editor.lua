function onload()
  GUID = self.getGUID()
  setXML()
end

---------------
-- Menu interaction
---------------
function dropdown(_, _, id)
  UI.setAttribute(id, "image", "d_forwardr")
  UI.setAttribute(id, "onClick", GUID .. "/dropdown_back")

  local n = UI.getAttribute(id, "n")
  local p = string.gsub(id, "r", "")

  if n == nil then n = 0 end

  local md = n * 25

  UI.setAttribute(p, "active", "true")
  UI.setAttribute(p, "preferredHeight", md)

  local id2 = "ed"

  for i = 1, n, 1 do
    local k = p .. "_" .. i
    local kp = "edr" .. string.sub(k, 3)
    UI.setAttribute(kp, "image", "d_forward")
    UI.setAttribute(kp, "onClick", GUID .. "/dropdown")
    UI.setAttribute(k, "active", "false")
  end

  for num in string.gmatch(id, "_%d") do
    id2 = id2 .. num
    if id2 ~= p then
      local c = UI.getAttribute(id2, "preferredHeight")
      UI.setAttribute(id2, "preferredHeight", md + c)
    end
  end

  UI.setAttribute("AEDITV", "active", false) -- Forces the state of the scrollbar to reset and update the p. heights
  UI.setAttribute("AEDITV", "active", true)
end

function dropdown_back(_, _, id)
  UI.setAttribute(id, "image", "d_forward")
  UI.setAttribute(id, "onClick", GUID .. "/dropdown")
  local p = string.gsub(id, "r", "")
  local d = string.gsub(p, "@.*", "")
  local n = string.gsub(id, ".*@", "")

  local n = UI.getAttribute(id, "n")
  local p = string.gsub(id, "r", "")

  if n == nil then n = 0 end

  local md = n * 25

  UI.setAttribute(p, "active", "false")

  local id2 = "ed"
  for num in string.gmatch(id, "_%d") do
    id2 = id2 .. num

    if id2 ~= p then
      local c = UI.getAttribute(id2, "preferredHeight")
      UI.setAttribute(id2, "preferredHeight", c - md)
    end
  end

  UI.setAttribute("AEDITV", "active", false) -- Forces the state of the scrollbar to reset and update the p. heights
  UI.setAttribute("AEDITV", "active", true)
end

---------------
-- Setup / Properties
---------------
function setXML()
  objects = getAllObjects()
  initial = [[
  <Defaults>
    <Text class="scrolltext" color="#000099" Alignment="MiddleLeft"/>
    <HorizontalLayout class="width" childForceExpandWidth="false" childForceExpandHeight="false" spacing="5"/>
    <panel class="icon" rectAlignment="MiddleLeft" raycastTarget="false" preserveAspect="false" minWidth="18" minHeight="18"/>
    <panel class="spacer" color=""/>
    <button class="dropdown" rectAlignment="MiddleLeft" image="d_forward" minWidth="16" minHeight="18" onClick="bde2a4/dropdown"/>
    <button class="select_b" image="" colors="|rgba(178,178,178,0.75)|#C8C8C8|rgba(0.78,0.78,0.78,0.5)" height="25" rectAlignment="UpperCenter" offsetXY="-4 5"/>
    <InputField class="transform" image="" characterLimit="6" characterValidation="Decimal"/>
  </Defaults>

  <panel height="900" width="400" id="AEDITV" color="rgba(194,194,194,0.8)" rectAlignment="MiddleRight"> \ <!-- WTF? -->
    <HorizontalLayout spacing="5">

    <panel color="rgba(0, 0, 0, 0.3)" height="69%" width="5%" rectAlignment="UpperLeft"/>
    <button height="69%" width="95%" color="" image="" rectAlignment="UpperRight" onClick="bde2a4/selectNone"/>
    <VerticalScrollView height="69%" width="95%" class="scrollView" color="" rectAlignment="UpperRight" verticalScrollbarVisibility="Permanent" movementType="Clamped" scrollSensitivity="30">
      <TableLayout id="Table" cellSpacing="-6" autoCalculateHeight="1" padding="5 5 5 5">
  ]]

  final = [[
  </TableLayout>
</VerticalScrollView>
</HorizontalLayout>
<panel height="29%" color="" rectAlignment="LowerRight">
  <HorizontalLayout spacing="5" Width="95%" height="12%" rectAlignment="UpperLeft"> <InputField id="name" image="" text="Cube"/><InputField id="guid" image="" text="bde2a4" readOnly="true"/></HorizontalLayout>
  <VerticalScrollView id="AEDITV" height="88%" width="100%" class="scrollView" color="" rectAlignment="LowerRight" verticalScrollbarVisibility="Permanent" movementType="Clamped" scrollSensitivity="30">
  <TableLayout id="Table2" cellSpacing="0" autoCalculateHeight="1" padding="5 5 5 5" cellBackgroundColor="">
    <Row preferredHeight="30"><cell><text>X</text><inputfield class="transform"  id="xt" text="0"/></cell><cell><text>Y</text><inputfield class="transform" id="yt" text="0"/></cell><cell><text>Z</text><inputfield class="transform" id="zt" text="0"/></cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="locked">Locked</Toggle></Cell><Cell><Toggle id="stp">Snap to Points</Toggle></Cell><Cell><Toggle id="stg">Snap to Grid</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="ar">Auto-Raise</Toggle></Cell><Cell><Toggle id="sticky">Sticky</Toggle></Cell><Cell><Toggle id="hands">Hands</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="hfd">Hide face-down</Toggle></Cell><Cell><Toggle id="rfw">Reveal FOW</Toggle></Cell><Cell><Toggle id="ifw">Ignore FOW</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="tooltip">Tooltip</Toggle></Cell><Cell><Toggle id="gridproj">Grid-Projection</Toggle></Cell><Cell><Toggle id="persistant">Persistent</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="interactable">Interactable</Toggle></Cell><Cell><Toggle id="gravity">Gravity</Toggle></Cell></Row>
    </TableLayout>
  </VerticalScrollView>
</panel>

</panel>
  ]]


  local edr = 0
  local added = ""
  local name = ""

  for b, x in pairs(objects) do
    edr = edr + 1

    if x.getName() ~= "" then
      name = x.getName()
    else
      name = x.tag
    end

    if x.tag == "Bag" then
      if type(countbag(x)) == "number" then
        added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><button class="dropdown" id="edr_'.. edr ..'" n="'.. countbag(x) ..'" /><panel class="icon" image="gameobject"/><Text class="scrolltext">'.. name ..'</Text></HorizontalLayout></Row>'
      else
        added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><panel class="spacer" minWidth="16"/><panel class="icon" image="gameobject"/><Text class="scrolltext">'.. name ..'</Text></HorizontalLayout></Row>'
      end
    else
      added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><panel class="spacer" minWidth="16"/><panel class="icon" image="gameobject"/><Text class="scrolltext">'.. name ..'</Text></HorizontalLayout></Row>'
    end
  end
  finished = UI.getXml() .. initial .. added .. final -- finish!
  Global.UI.setXml(finished)
end

function getProperties(_, guid, id)
  local obj = getObjectFromGUID(guid)

  -- Reset last selected
  if lastobj then
    lastobj.highlightOff()
    UI.setAttribute(lastui, "colors", "|rgba(178,178,178,0.75)|#C8C8C8|rgba(0.78,0.78,0.78,0.5)" )
  end
  --
  UI.setAttribute(id, "colors", "rgba(178,178,178,0.75)|#FFFFFF|#C8C8C8|rgba(0.78,0.78,0.78,0.2)" )
  obj.highlightOn("Green")

  local name = obj.getName()
  local parameters = checkAttributes(obj)

  if obj.getName() == "" then name = obj.tag end
  UI.setAttribute("name", "text", name)
  UI.setAttribute("xt", "text", parameters.transform.x)
  UI.setAttribute("yt", "text", parameters.transform.y)
  UI.setAttribute("zt", "text", parameters.transform.z)
  UI.setAttribute("locked", "isOn", parameters.locked)
  UI.setAttribute("stp", "isOn", parameters.STP)
  UI.setAttribute("stg", "isOn", parameters.STG)
  UI.setAttribute("ar", "isOn", parameters.raise)
  UI.setAttribute("sticky", "isOn", parameters.sticky)
  UI.setAttribute("hands", "isOn", parameters.hands)
  UI.setAttribute("hfd", "isOn", parameters.hfd)
  UI.setAttribute("rfw", "isOn", parameters.rfow)
  UI.setAttribute("ifw", "isOn", parameters.ifow)
  UI.setAttribute("tooltip", "isOn", parameters.tooltip)
  UI.setAttribute("gridproj", "isOn", parameters.grid_proj)
  UI.setAttribute("interactable", "isOn", parameters.interactable)
  UI.setAttribute("gravity", "isOn", parameters.gravity)

  lastui = id
  lastobj = obj
end

function selectNone()
  if lastobj then
    lastobj.highlightOff()
    UI.setAttribute(lastui, "colors", "|rgba(178,178,178,0.75)|#C8C8C8|rgba(0.78,0.78,0.78,0.5)")
  else
    -- nothing
  end
end



---------------
-- Utility
---------------
function countbag(bag) -- Returns # of items in a bag and false if none
  local i = 0
  if bag.getObjects()[1] then
    for x, b in pairs(bag.getObjects()) do
      i = i + 1
    end
  else
    return false
  end
  return i
end

function checkAttributes(obj) -- Returns a table of the objects attributes
local t = {
  transform = obj.getPosition(),
  guid = obj.getGUID(),
  locked = obj.getLock(),
  STP = obj.use_snap_points,
  STG = obj.use_grid,
  raise = obj.auto_raise,
  sticky = obj.sticky,
  hands = obj.use_hands,
  hfd = obj.hide_when_face_down,
  rfow = obj.getFogOfWarReveal().reveal,
  ifow = obj.ignore_fog_of_war,
  tooltip = obj.tooltip,
  grid_proj = obj.grid_projection,
  interactable = obj.interactable,
  gravity = obj.use_gravity
}
return t
end
