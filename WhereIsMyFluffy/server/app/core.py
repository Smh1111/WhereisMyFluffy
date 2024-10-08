import os
import certifi
from dotenv import load_dotenv
from pymongo import MongoClient
from app.internalService.authorization.authorizationService import AuthorizationService
from app.internalService.profile.profileService import ProfileService
from app.internalService.post.postService import PostService


ca = certifi.where()


def singleton(cls):
    instances = {}
    
    def get_instance(*args, **kwargs):
        if cls not in instances:
            instances[cls] = cls(*args, **kwargs)
        return instances[cls]
    
    return get_instance

@singleton
class Core:
    def __init__(self):
        self.plugins = {
            "external_service": {},
        }

        load_dotenv()

        uri = os.getenv("MONGODB_URI")
        if not uri:
            raise ValueError("MONGODB_URI not found in environment variables")
        
        self.client = MongoClient(uri, tlsCAFile = ca)
        self.db = self.client["MONGODB"]
        self.check_connection()

        self.authorization = AuthorizationService(self.db)
        self.profile = ProfileService(self.db)
        self.post = PostService(self.db)
    
    def check_connection(self):
        try:
            self.client.admin.command('ping') 
            print("Connected to MongoDB successfully!")
        except Exception as e:
            raise ConnectionError(f"Failed to connect to MongoDB: {str(e)}")

    def register_plugin(self, plugin_type, service_name, plugin):
        if plugin_type in self.plugins:
            self.plugins[plugin_type][service_name] = plugin
        else:
            raise ValueError(f"Unknown plugin type: {plugin_type}")

    def handle_request(self, plugin_type, service_name, data):
        if plugin_type in self.plugins and service_name in self.plugins[plugin_type]:
            plugin = self.plugins[plugin_type][service_name]
            return plugin.process(data)
        else:
            raise ValueError(f"No plugins registered for {plugin_type}/{service_name}")