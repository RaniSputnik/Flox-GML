import os, shutil, xml, zipfile;
import xml.etree.ElementTree as ET

# Constants
NEWLINE = '\n'
BUILD_DIRECTORY = 'build'
PROJECT_NAME = 'Flox'
EXT_NAME = 'Flox-GML'
OBJ_NAME = 'objFlox'
VERSION_CONST = 'fx_sdk_version'
OUTPUT_CONST_NAME = 'flox'
OUTPUT_OBJ_NAME = 'objFlox'
OUTPUT_SCRIPTS_NAME = 'flox'
OUTPUT_ZIP_NAME = 'flox-gml'

# Reads an xml file and returns the root node
def read_xml(dir):
	file = open(dir,"r")
	contents = file.read()
	file.close()
	return ET.fromstring(contents)

# Create the build directory if it does not exist
print("Building Flox Library")
curdir = os.path.dirname(os.path.realpath(__file__))
builddir = os.path.join(curdir,BUILD_DIRECTORY)
print(builddir)
if not os.path.exists(builddir):
	print("Creating output directory")
	os.makedirs(builddir)
else:
	print("Output directory exists")
	
# Read the contents of the project file
print("Reading project file...");
projectdir = os.path.join(curdir,PROJECT_NAME+".gmx")
projectpath = os.path.join(projectdir,PROJECT_NAME+".project.gmx")
projectxml = read_xml(projectpath)
print(">> Successfully read project file");
# Read the contents of the extension file
print("Reading extension file...")
extpath = os.path.join(projectdir,"extensions",EXT_NAME+".extension.gmx")
extxml = read_xml(extpath)
extversion = '0.0.0' # Will be set later
print(">> Successfully read extension file")

# Output the constants
# In the same pass we will calculate the version
print("Reading constants...")
files = extxml.find("files")
output = ""
for file in files.iter("file"):
	constants = file.find("constants")
	for constant in constants.iter("constant"):
		name = constant.find("name")
		value = constant.find("value")
		if name.text == VERSION_CONST:
			extversion = value.text[1:-1] # remove quote marks
		#print(name.text+"="+value.text)
		output += name.text + "=" + value.text + NEWLINE;
print(">> Successfully read constants")
print("Outputting constants...")
constpath = os.path.join(builddir,OUTPUT_CONST_NAME+".constants.txt")
outputfile = open(constpath,"w")
outputfile.write(output)
outputfile.close()
print(">> Successfully output constants")

# Copy the flox object to the build directory
print("Copying flox object")
existingobj = os.path.join(projectdir,"objects",OBJ_NAME+".object.gmx")
objpath = os.path.join(builddir,OUTPUT_OBJ_NAME+".object.gmx")
shutil.copyfile(existingobj, objpath)
print(">> Successfully copied flox object")

# Output the scripts
print("Reading scripts...")
output = ""
for scripts in projectxml.iter("scripts"):
	# Only output scripts inside the 'flox' group
	if scripts.get("name") == "flox":
		for script in scripts.iter("script"):
			scriptpath = os.path.join(projectdir,script.text)
			scriptnameandext = os.path.basename(scriptpath)
			scriptname = os.path.splitext(scriptnameandext)[0]
			#print(scriptname)
			scriptfile = open(scriptpath,"r")
			code = scriptfile.read()
			scriptfile.close()
			output += "#define " + scriptname + NEWLINE + code + NEWLINE;
print(">> Successfully read scripts")
print("Outputting scripts...")
scriptpath = os.path.join(builddir,OUTPUT_SCRIPTS_NAME+".scripts.gml")
outputfile = open(scriptpath,"w")
outputfile.write(output)
outputfile.close()
print(">> Successfully output scripts")

# Zip up the build
print(">> Flox version calculated as "+extversion)
print("Zipping up output...")
zippath = os.path.join(builddir,OUTPUT_ZIP_NAME+'.'+extversion+'.zip')
with zipfile.ZipFile(zippath, 'w') as z:
	z.write(constpath,OUTPUT_CONST_NAME+".constants.txt")
	z.write(objpath,OUTPUT_OBJ_NAME+".object.gmx")
	z.write(scriptpath,OUTPUT_SCRIPTS_NAME+".scripts.gml")
	z.close()
	