#!/bin/bash

error="install failed, please re-try this command"

echo "Installing frontend environment plugins"
echo ""
apm install minimap
if [[ $? -ne 0 ]]; then
    echo "minimap "$error
    exit 1
fi
apm install linter
if [[ $? -ne 0 ]]; then
    echo "linter "$error
    exit 1
fi
apm install linter-eslint
if [[ $? -ne 0 ]]; then
    echo "linter-eslint "$error
    exit 1
fi
apm install highlight-selected
if [[ $? -ne 0 ]]; then
    echo "highlight-selected "$error
    exit 1
fi
apm install file-icons
if [[ $? -ne 0 ]]; then
    echo "file-icons "$error
    exit 1
fi
apm install esformatter
if [[ $? -ne 0 ]]; then
    echo "esformatter "$error
    exit 1
fi
apm install emmet
if [[ $? -ne 0 ]]; then
    echo "emmet "$error
    exit 1
fi

osName=`uname  -s`

if [[ $osName == *"Linux"* ]]; then
    os="Linux"
elif [[ "$osName" == *"MINGW"* ]] || [[ "$osName" == *"CYGWIN"* ]]; then
    os='WINDOWS'
elif [[ "$osName" == *"Darwin"* ]]; then
    os='OSX'
fi

echo ""
echo "Frontend environment plugins installed"

echo ""
echo "Downloading .eslintrc"
curl http://leftstick.github.io/assets/scripts/eslintrc_browser_legacy.json > ~/.eslintrc_browser
curl http://leftstick.github.io/assets/scripts/eslintrc_node.json > ~/.eslintrc_node
echo ""

if [[ $os == "WINDOWS" ]]; then
    sed -i "s/LINEBREAK_OS/windows/g" ~/.eslintrc_browser
    sed -i "s/LINEBREAK_OS/windows/g" ~/.eslintrc_node
elif [[ $os == "OSX" ]]; then
    sed -i "" "s/LINEBREAK_OS/unix/g" ~/.eslintrc_browser
    sed -i "" "s/LINEBREAK_OS/unix/g" ~/.eslintrc_node
else
    sed -i "s/LINEBREAK_OS/unix/g" ~/.eslintrc_browser
    sed -i "s/LINEBREAK_OS/unix/g" ~/.eslintrc_node
fi

echo "Downloading .esformatter"
curl http://leftstick.github.io/assets/scripts/esformatter > ~/.esformatter

echo "Downloading snippets.cson"
curl http://leftstick.github.io/assets/scripts/snippets.cson > ~/.atom/snippets.cson

echo "Downloading config.cson"
curl http://leftstick.github.io/assets/scripts/config.cson > ~/.atom/config.cson

orgNodePath=`npm config get prefix`
nodePath=${orgNodePath//\\/\\\\\\\\}
nodePath=${nodePath//\//\\/}

if [[ $os == "OSX" ]]; then
    sed -i "" "s/UPDATE_NODE_PATH/$nodePath/g" ~/.atom/config.cson
else
    sed -i "s/UPDATE_NODE_PATH/$nodePath/g" ~/.atom/config.cson
fi
