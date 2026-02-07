def buildApp() {
    echo 'Building application...'
}

def testApp() {
    echo 'Testing application...'
}

def deployApp() {
    echo 'Deploying application...'
    echo "deploying version ${params.VERSION}"
}

def debugApp() {
    echo 'Debugging application...'
}

def policeApp() {
    echo 'Policing application traffic...'
}

return this
