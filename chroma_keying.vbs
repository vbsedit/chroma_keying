
Set img=CreateObject("vbsedit.imageprocessor")
img.Load "owl.png"

tola = 20
tolb = tola*1.3

'test de changement

Dim r_key
Dim g_key
Dim b_key
Dim cb_key
Dim cr_key

r_key = 112
g_key = 159
b_key = 89

cb_key = rgb2cb(r_key, g_key, b_key)
cr_key = rgb2cr(r_key, g_key, b_key) 
   

For y=0 To img.Height-1
  For x=0 To img.Width-1
    Set color = img.GetPixelColor(x,y)
       
    r=color.Red
    g=color.Green
    b=Color.Blue
    
    cb = rgb2cb(r,g,b)
    cr = rgb2cr(r,g,b)
    
    d = Sqr((cb_key-cb)^2+(cr_key-cr)^2)
  
    mask=1.0
    If d < tola Then
      mask= 0.0 
    ElseIf d < tolb Then
      mask =(d-tola)/(tolb-tola)
    End If
    
    color.Alpha = 255*mask
    
    img.SetPixelColor x,y,color
  Next
  If (y Mod 100)=0 Then
    WScript.Echo y & " / " & img.Height
  End If
Next

img.Save "owl_with_transparency.png"

Set image2=CreateObject("vbsedit.imageprocessor")
image2.Load "background.png"
image2.DrawImage "owl_with_transparency.png",0,0
image2.Save "owl_with_background.png"


Function rgb2y ( r,  g,  b) 
   rgb2y = Fix(0.299*r + 0.587*g + 0.114*b)
End Function 

Function rgb2cb ( r,  g,  b) 
   rgb2cb = Fix(128 + -0.168736*r - 0.331264*g + 0.5*b)
End Function

Function rgb2cr ( r,  g,  b) 
   rgb2cr = Fix(128 + 0.5*r - 0.418688*g - 0.081312*b) 
End Function
