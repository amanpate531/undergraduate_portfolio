import {SafeAreaView,View, TouchableOpacity, Platform} from "react-native";
import React from 'react';
import HeaderTitle from "../components/header";
import Camera from "../components/camera";
import Permissions from "react-native-permissions";
import Text from "../components/text";

export default class Cameras extends React.Component{

    static navigationOptions =  ({ navigation }) => {
        const {params} = navigation.state || {};
        return {
            headerTitle : <HeaderTitle title={params.title} />
        }
    };

    state = {
        cameraPermission: undefined,
    };

    componentDidMount(){
        Permissions.check('camera').then(response => {
            if(response === "undetermined"){
                Permissions.request('camera').then(response => {
                    this.setState({ cameraPermission: response })
                })
            } else this.setState({ cameraPermission: response })
        });
    }


    render(){
        return(
            <SafeAreaView style={{flex : 1, backgroundColor : "white"}}>
                {((this.state.cameraPermission === "denied" && Platform.OS === "ios") ||
                (this.state.cameraPermission === "restricted" && Platform.OS === "android")) && <View style={{padding : 16,
                    alignItems: "center"}}>
                    <TouchableOpacity style={{alignItems : "center"}} onPress={Permissions.openSettings} >
                        <Text style={{textAlign: "center", fontSize: 16, color: "black"}} 
                            value={"Click to give the camera permission from the app settings to capture the label."}
                        />
                    </TouchableOpacity>
                </View>}
                {this.state.cameraPermission === "authorized" &&
                <Camera 
                />}

            </SafeAreaView>
        );
    }
}