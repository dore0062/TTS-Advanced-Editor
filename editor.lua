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
    <InputField class="transform" image="" characterLimit="6" characterValidation="Decimal" onValueChanged="bde2a4/setTransform"/>
    <Toggle class="toggle" onValueChanged="bde2a4/setAttribute"/>
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
  <HorizontalLayout spacing="5" Width="95%" height="12%" rectAlignment="UpperLeft"> <InputField id="name" image="" text="Cube" onEndEdit="bde2a4/setName"/><InputField id="guid" image="" text="bde2a4" readOnly="true"/></HorizontalLayout>
  <VerticalScrollView id="AEDITV" height="88%" width="100%" class="scrollView" color="" rectAlignment="LowerRight" verticalScrollbarVisibility="Permanent" movementType="Clamped" scrollSensitivity="30">
  <TableLayout id="Table2" cellSpacing="0" autoCalculateHeight="1" padding="5 5 5 5" cellBackgroundColor="">
    <Row preferredHeight="30"><cell><text>X</text><inputfield class="transform"  id="xt" text="0"/></cell><cell><text>Y</text><inputfield class="transform" id="yt" text="0"/></cell><cell><text>Z</text><inputfield class="transform" id="zt" text="0"/></cell></Row>
    <Row preferredHeight="30"><cell><text>XR</text><inputfield class="transform"  id="xr" text="0"/></cell><cell><text>YR</text><inputfield class="transform" id="yr" text="0"/></cell><cell><text>ZR</text><inputfield class="transform" id="zr" text="0"/></cell></Row>
    <Row preferredHeight="30"><cell><text>XS</text><inputfield class="transform"  id="xs" text="0"/></cell><cell><text>YS</text><inputfield class="transform" id="ys" text="0"/></cell><cell><text>ZS</text><inputfield class="transform" id="zs" text="0"/></cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="locked" class="toggle">Locked</Toggle></Cell><Cell><Toggle id="stp" class="toggle">Snap to Points</Toggle></Cell><Cell><Toggle id="stg" class="toggle">Snap to Grid</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="ar" class="toggle">Auto-Raise</Toggle></Cell><Cell><Toggle id="sticky" class="toggle">Sticky</Toggle></Cell><Cell><Toggle id="hands" class="toggle">Hands</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="hfd" class="toggle">Hide face-down</Toggle></Cell><Cell><Toggle id="rfw" class="toggle">Reveal FOW</Toggle></Cell><Cell><Toggle id="ifw" class="toggle">Ignore FOW</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="tooltip" class="toggle">Tooltip</Toggle></Cell><Cell><Toggle id="gridproj" class="toggle">Grid-Projection</Toggle></Cell><Cell><Toggle id="persistant" class="toggle">Persistent</Toggle></Cell></Row>
    <Row preferredHeight="30"><Cell><Toggle id="interactable" class="toggle">Interactable</Toggle></Cell><Cell><Toggle id="gravity" class="toggle">Gravity</Toggle></Cell></Row>
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
      if x.AssetBundle then
        local t = x.getChildren()
        name = tostring(t[1])
      else
        name = x.tag
      end
    end

    if x.AssetBundle then
      local t = x.getChildren() -- Top level only
      local b = extractChild(x, {tostring(t[1])}).getChildren()
      if b[1] then
        local toadd, numadd = recursiveExtraction(edr, t, x)
        local id = '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><button class="dropdown" id="edr_'.. edr ..'" n="'.. numadd ..'" /><panel class="icon" image="gameobject"/><Text class="scrolltext" id="'.. edr ..'n" text = "'.. name ..'"/></HorizontalLayout></Row>'
        added = added .. id .. toadd
      else
        added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><panel class="spacer" minWidth="16"/><panel class="icon" image="gameobject"/><Text class="scrolltext" id="'.. edr ..'n" text = "'.. name ..'"/></HorizontalLayout></Row>'
      end
      else if x.tag == "Bag" then
        if type(countbag(x)) == "number" then
          added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><button class="dropdown" id="edr_'.. edr ..'" n="'.. countbag(x) ..'" /><panel class="icon" image="gameobject"/><Text class="scrolltext" id="'.. edr ..'n" text = "'.. name ..'"/></HorizontalLayout></Row>'
        else
          added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><panel class="spacer" minWidth="16"/><panel class="icon" image="gameobject"/><Text class="scrolltext" id="'.. edr ..'n" text = "'.. name ..'"/></HorizontalLayout></Row>'
        end
      else
        added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edr .. '_btn" onClick="bde2a4/getProperties('.. x.getGUID() ..')"/><HorizontalLayout class="width"><panel class="spacer" minWidth="16"/><panel class="icon" image="gameobject"/><Text class="scrolltext" id="'.. edr ..'n" text = "'.. name ..'"/></HorizontalLayout></Row>'
      end
    end
  end

  finished = UI.getXml() .. initial .. added .. final -- finish!
  Global.UI.setXml(finished)
end

function recursiveExtraction(edr, children_table, obj, level) -- Extracts all components of an assetbundle
  if not level then level = 1 end

  local spacer = 16 * level -- Controls how far the tab is
  local added = ""
  local start = '<Row preferredHeight="60" id="ed_'.. edr ..'" active="false"><TableLayout cellSpacing = "-6" >'
  local finish = '</TableLayout></Row>'
  local edm = 0
  for l, b in pairs(children_table) do
    edm = edm + 1
    local edt = edr .. "_" .. edm

    if b.getChildren() then
      local toadd, numadd = recursiveExtraction(edt, b.getChildren(), obj, level + 1)
      id = '<Row preferredHeight="30"><button class ="select_b" id = "'.. edt ..'_btn" onClick="bde2a4/nil"/><HorizontalLayout class="width"><panel class="spacer" minWidth="'.. spacer ..'"/><button class="dropdown" id="edr_'.. edt ..'" n="'.. numadd ..'" /><panel class="icon" image="gameobject"/><Text class="scrolltext" id="'.. edt ..'n" text = "'.. tostring(b) ..'"/></HorizontalLayout></Row>'
      added = added .. id .. toadd
    else
      added = added .. '<Row preferredHeight="30"><button class ="select_b" id = "'.. edt ..'_btn" onClick="bde2a4/nil"/><HorizontalLayout class="width"><panel class="spacer" minWidth="'.. spacer ..'"/><panel class="icon" image="gameobject"/><Text class="scrolltext" id="'.. edt ..'n" text = "'.. name ..'"/></HorizontalLayout></Row>'
    end
  end

if edm == 0 then
  return "", 0
else

  return start .. added .. finish, edm
end
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
if obj == lastobj then
  for _, player in ipairs(Player.getPlayers()) do
    if player.host == true then
      player.lookAt({
        position = obj.getPosition(),
        pitch = 25,
        yaw = 180,
        distance = 20
      })
    end

  end
  return nil
end
lastui = id
lastobj = obj
CV = false

local name = obj.getName()
if obj.getName() == "" then name = "" end
UI.setAttribute("name", "text", name)

Wait.frames(checkValues, 6) -- Prevents recursion. Courtines would be better but eff that lmao
Wait.frames(function() CV = true end, 5)
end

function selectNone()
if lastobj then
  lastobj.highlightOff()
  UI.setAttribute(lastui, "colors", "|rgba(178,178,178,0.75)|#C8C8C8|rgba(0.78,0.78,0.78,0.5)")
  CV = false
else
  -- nothing
end
end

function setAttribute(_, bool, id) -- Parameters make no sense.
if bool == "True" then bool = true else bool = false end
if id == "locked" then
  lastobj.setLock(bool)
elseif id == "stp" then
  lastobj.use_snap_points = bool
elseif id == "stg" then
  lastobj.use_grid = bool
elseif id == "ar" then
  lastobj.auto_raise = bool
elseif id == "sticky" then
  lastobj.sticky = bool
elseif id == "hands" then
  lastobj.use_hands = bool
elseif id == "hfd" then
  lastobj.hide_when_face_down = bool
elseif id == "rfw" then
  lastobj.setFogOfWarReveal({reveal = bool})
elseif id == "ifw" then
  lastobj.ignore_fog_of_war = bool
elseif id == "tooltip" then
  lastobj.tooltip = bool
elseif id == "gridproj" then
  lastobj.grid_projection = bool
elseif id == "interactable" then
  lastobj.interactable = bool
elseif id == "gravity" then
  lastobj.use_gravity = bool
end
end

function setName(_, text)
lastobj.setName(text)
local p = string.gsub(lastui, "_btn", "")
UI.setAttribute(p .. "n", "text", text)
end

function checkValues()
local obj = lastobj
local parameters = checkAttributes(obj)

if obj.getName() == "" then
  if obj.AssetBundle then
    local t = obj.getChildren()
    name = tostring(t[1])
  else
    name = obj.tag
  end
  setName(_, name)
end

UI.setAttribute("xt", "text", parameters.transform.x)
UI.setAttribute("yt", "text", parameters.transform.y)
UI.setAttribute("zt", "text", parameters.transform.z)
UI.setAttribute("xr", "text", parameters.rotation.x)
UI.setAttribute("yr", "text", parameters.rotation.y)
UI.setAttribute("zr", "text", parameters.rotation.z)
UI.setAttribute("xs", "text", parameters.scale.x)
UI.setAttribute("ys", "text", parameters.scale.y)
UI.setAttribute("zs", "text", parameters.scale.z)
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

if CV == true then
  Wait.frames(checkValues, 5)
end
end

function setTransform(_, t, id)
local cpos = lastobj.getPosition()
if id == "xt" then
  lastobj.setPosition({t, cpos.y, cpos.z})
elseif id == "yt" then
  lastobj.setPosition({cpos.x, t, cpos.z})
elseif id == "zt" then
  lastobj.setPosition({cpos.x, cpos.y, t})
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
  rotation = obj.getRotation(),
  scale = obj.getScale(),
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

function extractChild(element, children) -- Credit to dzikakulka. Extracts children/components easily
assert(type(children) == "table", "children must be in table")
logStyle("error", "Red")
for _, name in ipairs(children) do
  assert(type(name) == "string", "children names must be a string")
  if element.getChild(name) == nil then
    log(element.getChildren(), "children available:", "error")
    log(children, "children selected:", "error")
    error("child does not exist: " .. name)
  end
  element = element.getChild(name)
end
return element
end
